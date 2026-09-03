#!/bin/sh
# Claude Code の使用率とリセット時刻（5 時間セッション枠 / 週次枠）を 1 行で返す。
# herdr の tab_bar_right から呼ばれる。
#
# 実行間隔は config.toml の interval_seconds が握るので、取得の間引きはしない。
# herdr は成功時の最終行だけを使い、失敗・空出力・タイムアウトでは表示を消すので、
# 取れなかった経路はすべて exit 0 に倒す。
#
# ただし無出力で倒すと、この endpoint がときどき返す 429 の 1 回で行が丸ごと消え、
# 次のポーリングまでの 2 分間なにも出なくなる。直近の成功値を控えておいて、
# 新しいうちはそれを出す。15 分は 7 回分の空振りに耐える幅で、その間リセット時刻は
# 変わらず、使用率も表示を誤らせるほどは動かない。
set -eu

cache="${TMPDIR:-/tmp}/herdr-claude-usage"

# 失敗したときの出口。控えが新しければそれを、無ければ何も出さずに終わる。
fallback() {
    if [ -f "$cache" ] && [ -n "$(find "$cache" -mmin -15 2>/dev/null)" ]; then
        cat "$cache"
    fi
    exit 0
}

token=$(security find-generic-password -s 'Claude Code-credentials' -w 2>/dev/null |
    jq -r '.claudeAiOauth.accessToken // empty') || fallback
[ -n "$token" ] || fallback

# 新しいアカウントは five_hour / seven_day が消えて limits[] に移っているので両方見る。
# 片方しか取れなければ取れた方だけを出す。
#
# resets_at は "…T05:50:00.236315+00:00" の形。jq の fromdateiso8601 は小数秒も
# 数値オフセットも受け取らないので、秒までを切り出して Z として読み、オフセット分を
# 引き戻してから strflocaltime でローカル時刻にする。読めなかったら時刻だけ落とす。
usage=$(curl -fsS --max-time 5 https://api.anthropic.com/api/oauth/usage \
    -H "Authorization: Bearer $token" \
    -H 'anthropic-beta: oauth-2025-04-20' |
    jq -r '
        def epoch:
            capture("^(?<t>.{19})(?:\\.[0-9]+)?(?:Z|(?<sg>[+-])(?<oh>\\d\\d):(?<om>\\d\\d))$")
            | (.t + "Z" | fromdateiso8601)
              - ((.sg // "+") + "1" | tonumber)
                * (((.oh // "0") | tonumber) * 3600 + ((.om // "0") | tonumber) * 60);
        def at($fmt):
            ([try (strings | epoch | strflocaltime($fmt)) catch empty] | first) as $t
            | if $t == null then "" else " →\($t)" end;
        def win($label; $flat; $kind; $fmt):
            ([.limits[]? | select(.kind == $kind)] | first) as $l
            | ($flat.utilization // $l.percent) as $percent
            | if $percent == null then empty
              else "\($label) \($percent | round)%" + (($flat.resets_at // $l.resets_at) | at($fmt))
              end;
        [ win("5h"; .five_hour; "session"; "%H:%M"),
          win("7d"; .seven_day; "weekly_all"; "%-m/%-d %H:%M") ]
        | join(" · ")
    ') || fallback
[ -n "$usage" ] || fallback

printf '%s\n' "$usage" >"$cache.$$" 2>/dev/null && mv -f "$cache.$$" "$cache" 2>/dev/null || :
printf '%s\n' "$usage"
