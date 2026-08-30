#!/bin/sh
# Claude Code の使用率（5 時間セッション枠 / 週次枠）を 1 行で返す。
# herdr の tab_bar_right から呼ばれる。
#
# 実行間隔は config.toml の interval_seconds が握るので、ここではキャッシュしない。
# herdr は成功時の最終行だけを使い、失敗・空出力・タイムアウトでは表示を消すので、
# 取れなかった経路はすべて「無出力で exit 0」に倒す。
set -eu

token=$(security find-generic-password -s 'Claude Code-credentials' -w 2>/dev/null |
    jq -r '.claudeAiOauth.accessToken // empty') || exit 0
[ -n "$token" ] || exit 0

# 新しいアカウントは five_hour / seven_day が消えて limits[] に移っているので両方見る。
# 片方しか取れなければ取れた方だけを出す。
usage=$(curl -fsS --max-time 5 https://api.anthropic.com/api/oauth/usage \
    -H "Authorization: Bearer $token" \
    -H 'anthropic-beta: oauth-2025-04-20' |
    jq -r '
        def limit($kind): [.limits[]? | select(.kind == $kind) | .percent] | first;
        def fmt($label; $v): if $v == null then empty else "\($label) \($v | round)%" end;
        [ fmt("5h"; .five_hour.utilization // limit("session")),
          fmt("7d"; .seven_day.utilization // limit("weekly_all")) ]
        | join(" · ")
    ') || exit 0
[ -n "$usage" ] || exit 0

printf '%s\n' "$usage"
