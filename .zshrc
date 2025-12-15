#!/usr/bin/env zsh

# =======================================================
# path
# =======================================================

export XDG_CONFIG_HOME="$HOME/.config"

# Homebrew PATH initialization (must be early)
if [[ "$(uname)" = "Darwin" ]]; then
    if [[ -d /opt/homebrew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -d /usr/local/homebrew ]]; then # For older installations
        eval "$(/usr/local/homebrew/bin/brew shellenv)"
    fi
elif [[ "$(uname)" = "Linux" ]]; then
    if [[ -d /home/linuxbrew/.linuxbrew ]]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    elif [[ -d $HOME/.linuxbrew ]]; then
        eval "$($HOME/.linuxbrew/bin/brew shellenv)"
    fi
fi

# Ensure $HOME/.local/bin is in PATH after Homebrew, but before other tools
export PATH="$HOME/.local/bin:$PATH"

# ghq
if (( ${+commands[ghq]} )); then
    GHQ_ROOT="$(ghq root)"
fi

# asdf
if (( ${+commands[asdf]} )); then
    export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fi

# rust env
if [[ -d "$HOME/.cargo/bin" ]]; then
    export RUST_BACKTRACE=1
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# go env
if (( ${+commands[go]} )); then
    export GOPATH="$HOME/.go"
    export GO111MODULE=on

    if [[ -v GOROOT ]]; then
        export PATH="$GOROOT/bin:$PATH"
    fi
    export PATH="$GOPATH/bin:$PATH"
fi

# =======================================================
# completion
# =======================================================

autoload -Uz compinit
# Skip check for speed
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit -C
else
  compinit
fi

if [[ ${ZDOTDIR:-$HOME}/.zcompdump -nt ${ZDOTDIR:-$HOME}/.zcompdump.zwc || ! -f ${ZDOTDIR:-$HOME}/.zcompdump.zwc ]]; then
  zcompile ${ZDOTDIR:-$HOME}/.zcompdump
fi

# =======================================================
# shell
# =======================================================

eval "$(starship init zsh)"

# sheldon
SHELDON_CONFIG_FILE="$HOME/.config/sheldon/plugins.toml"
SHELDON_INIT_FILE="$HOME/.config/sheldon/init.zsh"

if [[ ! -f "$SHELDON_INIT_FILE" || "$SHELDON_CONFIG_FILE" -nt "$SHELDON_INIT_FILE" ]]; then
    if (( ${+commands[sheldon]} )); then
        sheldon source > "$SHELDON_INIT_FILE"
    fi
fi

if [[ -f "$SHELDON_INIT_FILE" ]]; then
    source "$SHELDON_INIT_FILE"
fi

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

if (( ${+commands[git]} )); then
    alias git-branch-prune='git branch --format "%(refname:short) %(upstream:track)" | grep "\[gone\]" | cut -d" " -f1 | xargs -I1 git branch -d 1'
fi

if (( ${+commands[eza]} )); then
    alias ls='eza --icons'
    alias la='eza -a --icons'
    alias ll='eza -hlg --time-style long-iso --icons'
    alias lla='eza -hlga --time-style long-iso --icons'
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

if (( ${+commands[ghq]} )); then
    # GHQ_ROOT is already set above
    alias cdg='cd $(ghq root)/$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")'
fi

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

# =======================================================
# functions
# =======================================================

chpwd() {
    ls
}

dotfiles() {
    local cmd="$1"
    local dotpath="$HOME/.dotfiles"
    
    case "$cmd" in
        list)
            "$dotpath/script/list"
            ;;
        update)
            autoload -Uz catch
            autoload -Uz throw

            (
                cd "$dotpath" && {
                    git pull || throw 'PullError'
                    "$dotpath/script/deploy" || throw 'DeployError'
                }
            )
            exec zsh -l
            ;;
        *)
            echo "Usage: dotfiles {list|update}"
            ;;
    esac
}

# =======================================================
# local
# =======================================================

[ -f "$HOME/.zlocal" ] && source "$HOME/.zlocal"
