#!/usr/bin/env zsh

# zsh
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history

FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
autoload -Uz compinit
compinit

# shellcheck source=/dev/null
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
# shellcheck source=/dev/null
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

if [ "$(uname)" = "Linux" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ "$(uname)" = "Darwin" ]; then
    eval "$(anyenv init -)"
fi

if [ $UID -eq 0 ]; then
    PROMPT="%F{red}%n@%m: %~%F{cyan}%c %F{reset_color}%% "
else
    PROMPT="%F{green}%n@%m: %F{cyan}%c %F{reset_color}%% "
fi

# vcs info
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
RPROMPT='${vcs_info_msg_0_}'

# shellcheck source=/dev/null
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

precmd() {
    vcs_info
}
