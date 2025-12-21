# =======================================================
# completion
# =======================================================

[ ! -d "$XDG_CACHE_HOME/zsh" ] && mkdir -p "$XDG_CACHE_HOME/zsh"

_Z_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump"

autoload -Uz compinit

if [[ -n ${_Z_COMPDUMP}(#qN.mh+24) ]]; then
  compinit -d "$_Z_COMPDUMP"
else
  compinit -C -d "$_Z_COMPDUMP"
fi

if [[ $_Z_COMPDUMP -nt ${_Z_COMPDUMP}.zwc || ! -f ${_Z_COMPDUMP}.zwc ]]; then
  zcompile "$_Z_COMPDUMP"
fi
