#!/usr/bin/env zsh

# =======================================================
# path
# =======================================================

export XDG_CONFIG_HOME="$HOME/.config"

export PATH="$HOME/.local/bin:$PATH"

#homebrew
if [[ "$(uname)" = "Darwin" && -d /opt/homebrew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ghq
if type ghq >/dev/null 2>&1; then
    GHQ_ROOT="$(ghq root)"
fi

# asdf
if type asdf >/dev/null 2>&1; then
    export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fi

# rust env
if [[ -d $HOME/.cargo/bin ]] then
    export RUST_BACKTRACE=1
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# go env
if type go >/dev/null 2>&1; then
    export GOPATH="$HOME/.go"
    export GO111MODULE=on

    if [ -v GOROOT ]; then
        export PATH="$GOROOT/bin:$PATH"
    fi
    export PATH="$GOPATH/bin:$PATH"
fi

# =======================================================
# launch tmux
# =======================================================

# if [[ ! -n $TMUX && -z $SSH_CONNECTION ]]; then
#     if type fzf >/dev/null 2>&1; then
#         ID="$(tmux list-sessions 2 >/dev/null)"
#         if [[ -z "$ID" ]]; then
#             exec tmux new-session
#         fi
#
#         create_new_session="Create New Session"
#         ID="$ID\n${create_new_session}:"
#         ID="$(echo -e "$ID" | fzf --reverse | cut -d: -f1)"
#
#         if [[ "$ID" = "${create_new_session}" ]]; then
#             exec tmux new-session
#         elif [[ -n "$ID" ]]; then
#             exec tmux attach-session -t "$ID"
#         else
#             :
#         fi
#     else
#         exec tmux -u new-session -A -s main
#     fi
# fi

# =======================================================
# shell
# =======================================================

eval "$(starship init zsh)"

eval "$(sheldon source)"

# zsh
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt no_share_history

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000
export SAVEHIST=1000000

# command init
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

export BAT_THEME=ansi

# =======================================================
# alias
# =======================================================

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

# =======================================================
# functions
# =======================================================

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

# =======================================================
# local
# =======================================================

[ -f "$HOME/.zlocal" ] && source "$HOME/.zlocal"
