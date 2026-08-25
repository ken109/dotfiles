# =======================================================
# completion
# =======================================================

[ ! -d "$XDG_CACHE_HOME/zsh" ] && mkdir -p "$XDG_CACHE_HOME/zsh"

_Z_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump"

autoload -Uz compinit

# [[ ]] の中ではファイル名生成が起きず glob 修飾子が展開されないため、判定は配列展開で行う。
# また (#q...) は extendedglob を要求するが、このファイルは options.zsh より先に読まれるので
# 無名関数の中だけで局所的に有効化する。
# 24時間以上経過していればフルの compinit、それ以外はセキュリティチェックを省いた compinit -C。
_z_compdump_is_stale() {
    setopt local_options extendedglob
    local -a stale=(${_Z_COMPDUMP}(#qN.mh+24))
    (( ${#stale} ))
}

if _z_compdump_is_stale; then
    compinit -d "$_Z_COMPDUMP"
    # compinit は補完関数に変化が無いと dump を書き直さない。mtime を更新しないと
    # 一度古くなった dump が二度と新鮮にならず、毎回フルスキャンに落ち続ける。
    touch "$_Z_COMPDUMP"
else
    compinit -C -d "$_Z_COMPDUMP"
fi
unfunction _z_compdump_is_stale

if [[ $_Z_COMPDUMP -nt ${_Z_COMPDUMP}.zwc || ! -f ${_Z_COMPDUMP}.zwc ]]; then
    zcompile "$_Z_COMPDUMP"
fi

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
