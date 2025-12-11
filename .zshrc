#!/usr/bin/env zsh

eval "$(sheldon source)"

# shell
fpath+=$HOME/.zsh/pure

export BAT_THEME=ansi

# pure
autoload -U promptinit; promptinit

prompt pure

# zsh
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt no_share_history

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000
export SAVEHIST=1000000

export PATH="$HOME/.local/bin:$PATH"

# command init
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

# aliases
alias ...='cd ../..'
alias ....='cd ../../..'

if type git >/dev/null 2>&1; then
  alias git-branch-prune='git branch --format "%(refname:short) %(upstream:track)" | grep "\[gone\]" | cut -d" " -f1 | xargs -I1 git branch -d 1'
fi

if type eza >/dev/null 2>&1; then
    alias ls='eza --icons'
    alias la='eza -a --icons'
    alias ll='eza -hlg --time-style long-iso --icons'
    alias lla='eza -hlga --time-style long-iso --icons'
else
    alias la='ls -a'
    alias ll='ls -l'
    alias lla='ls -la'
fi

if type nvim >/dev/null 2>&1; then
    alias vim='nvim'
    export EDITOR="$(which nvim)"
fi

alias grep='grep --color=auto'

if type ghq >/dev/null 2>&1; then
    GHQ_ROOT="$(ghq root)"
    alias cdg='cd $(ghq root)/$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")'
fi

if type trash >/dev/null 2>&1; then
    alias rm='trash'
fi

if type trans >/dev/null 2>&1; then
    alias ja-en='trans {ja=en}'
    alias en-ja='trans {en=ja}'
fi

if type kubectl >/dev/null 2>&1; then
    alias k='kubectl'
fi

# functions
chpwd() {
    ls
}

dotfiles-update() {
    autoload -Uz catch
    autoload -Uz throw

    (
        cd $HOME/.dotfiles && {
            git pull || throw 'PullError'
            make deploy || throw 'MakeError'
        }
    )

    exec zsh -l
}

[ -f "$HOME/.zlocal" ] && source "$HOME/.zlocal"
