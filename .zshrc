#!/usr/bin/env zsh

# zsh
setopt hist_ignore_dups
setopt hist_ignore_all_dups

setopt auto_cd

setopt auto_pushd
setopt pushd_ignore_dups

zstyle ':completion:*:default' menu select=1

if [ $UID -eq 0 ]; then
    PROMPT="%F{red}%n@%m: %F{cyan}%c %F{reset_color}%% "
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

show_command_end_time() {
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

# command init
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"
[ -f "$HOME/.asdf/asdf.sh" ] && source "$HOME/.asdf/asdf.sh"

# complettion
if type brew >/dev/null 2>&1; then
    if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
        source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    fi

    if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
        source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    fi

    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi
if type asdf >/dev/null 2>&1; then
    FPATH=${ASDF_DIR}/completions:$FPATH
fi
autoload -Uz compinit
compinit

if type flutter >/dev/null 2>&1; then
    eval "$(flutter zsh-completion)"
fi

# aliases
alias ...='cd ../..'
alias ....='cd ../../..'

if type exa >/dev/null 2>&1; then
    alias ls='exa'
    alias la='exa -a'
    alias ll='exa -hlg --git --time-style long-iso'
    alias lla='exa -hlga --git --time-style long-iso'
else
    alias la='ls -a'
    alias ll='ls -l'
    alias lla='ls -la'
fi

if type nvim >/dev/null 2>&1; then
    alias vim='nvim'
fi

alias grep='grep --color=auto'
alias cdg='cd $(ghq root)/$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")'

if type trash >/dev/null 2>&1; then
    alias rm='trash'
fi

if [ "$(uname)" = "Darwin" ]; then
    alias rdns='sudo killall -HUP mDNSResponder'
fi

# functions
chpwd() {
    ls
}

precmd() {
    vcs_info
}
