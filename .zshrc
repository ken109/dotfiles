#!/usr/bin/env zsh
# written by kensuke kubo

# zsh
FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
autoload -Uz compinit
compinit

setopt hist_ignore_dups
setopt hist_ignore_all_dups

setopt auto_cd

setopt auto_pushd
setopt pushd_ignore_dups

zstyle ':completion:*:default' menu select=1

source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

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

# cmd time
export PREV_COMMAND_END_TIME
export NEXT_COMMAND_BGN_TIME

function show_command_end_time() {
    PREV_COMMAND_END_TIME=$(date "+%H:%M:%S")
    RPROMPT="${vcs_info_msg_0_} [${PREV_COMMAND_END_TIME} -         ]"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd show_command_end_time

show_command_begin_time() {
    NEXT_COMMAND_BGN_TIME=$(date "+%H:%M:%S")
    RPROMPT="${vcs_info_msg_0_} [${PREV_COMMAND_END_TIME} - ${NEXT_COMMAND_BGN_TIME}]"
    zle .accept-line
    zle .reset-prompt
}
zle -N accept-line show_command_begin_time

[ -f ~/.fzf.zsh ] && source "$HOME/.fzf.zsh"

eval "$(flutter bash-completion)"

# aliases
alias ...='cd ../..'
alias ....='cd ../../..'

alias ls='exa'
alias la='exa -a'
alias ll='exa -hlg --git --time-style long-iso'
alias lla='ls -hlga --git --time-style long-iso'
alias vim='nvim'

if [ "$(uname)" = "Darwin" ]; then
    alias rdns='sudo killall -HUP mDNSResponder'
    alias rm='trash'
    alias cdg='cd $(ghq root)/$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")'
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
