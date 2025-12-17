# =======================================================
# alias
# =======================================================
if (( ${+commands[eza]} )); then
    alias ls='eza --icons --group-directories-first'
    alias la='eza -a --icons --group-directories-first'
    alias ll='eza -hlg --time-style=long-iso --icons --group-directories-first'
    alias lla='eza -hlga --time-style=long-iso --icons --group-directories-first'
else
    alias la='ls -a'
    alias ll='ls -l'
    alias lla='ls -la'
fi

if (( ${+commands[nvim]} )); then
    alias vim='nvim'
    export EDITOR="$(which nvim)"
fi

alias grep='grep --color=auto'

if (( ${+commands[trash]} )); then
    alias rm='trash'
fi

if (( ${+commands[trans]} )); then
    alias ja-en='trans {ja=en}'
    alias en-ja='trans {en=ja}'
fi

if (( ${+commands[kubectl]} )); then
    alias k='kubectl'
fi
