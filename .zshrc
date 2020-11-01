#!/usr/bin/env zsh

if [ "$(uname)" = "Linux" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ "$(uname)" = "Darwin" ]; then
    eval "$(anyenv init -)"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# aliases
alias ls='exa'
alias la='exa -a'
alias ll='exa -hlg --git --time-style long-iso'
alias lla='ls -hlga --git --time-style long-iso'
alias vim='nvim'

if [ "$(uname)" = "Darwin" ]; then
    alias rdns='sudo killall -HUP mDNSResponder'
    alias rm='trash'
    alias cdg='cd (ghq root)/(ghq list | fzf)'
fi

# functions
set_pyenv() {
    search=""
    pyenv_name="base"
    for now in $(pwd | tr '/' '\n'); do
        search="$search/$now"
        if [ -f "$search/.python-version" ]; then
            pyenv_name="$(sed -e 's:.*/::g' <"$search/.python-version")"
        fi
    done
    conda activate "$pyenv_name"
}

chpwd() {
    ls
    if [ "$(uname)" = "Darwin" ]; then
        set_pyenv
    fi
}
