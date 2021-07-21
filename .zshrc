#!/usr/bin/env zsh

if [ "$(uname)" = "Linux" ]; then
    if [ -d ~/.linuxbrew ]; then
        eval "$(~/.linuxbrew/bin/brew shellenv)"
    elif [ -d /home/linuxbrew/.linuxbrew ]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
elif [ "$(uname)" = "Darwin" ]; then
    export PATH="/usr/local/bin:$PATH"
fi

# shell
export BAT_THEME=ansi-dark

if type ghq >/dev/null 2>&1; then
    GHQ_ROOT="$(ghq root)"

    if [ -d "$GHQ_ROOT/github.com/flutter/flutter" ]; then
        export PATH="$GHQ_ROOT/github.com/flutter/flutter/bin/:$PATH"
    fi
fi

if [ "$(uname)" = "Darwin" ]; then
    export CLOUDSDK_PYTHON=python
fi

# rust env
export RUST_BACKTRACE=1
export PATH="$HOME/.cargo/bin:$PATH"

# go env
export GOPATH="$HOME/.go"
export GO111MODULE=on

export PATH="$GOROOT/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"

# brew
if type brew >/dev/null 2>&1; then
    brew_prefix="$(brew --prefix)"

    export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="$brew_prefix/share/zsh-syntax-highlighting/highlighters"
    export LIBRARY_PATH="$brew_prefix/opt/openssl/lib/:$LIBRARY_PATH"

    # php build
    export PATH="$brew_prefix/opt/bison/bin:$PATH"
    export PKG_CONFIG_PATH="$brew_prefix/opt/icu4c/lib/pkgconfig:$brew_prefix/opt/krb5/lib/pkgconfig:$brew_prefix/opt/libedit/lib/pkgconfig:$brew_prefix/opt/libxml2/lib/pkgconfig:$brew_prefix/opt/openssl@1.1/lib/pkgconfig:$PKG_CONFIG_PATH"
fi

###############################################################################

# zsh
setopt hist_ignore_dups
setopt hist_ignore_all_dups

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000
export SAVEHIST=1000000

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
RPROMPT="${vcs_info_msg_0_}"

# command init
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"
[ -f "$HOME/.asdf/asdf.sh" ] && source "$HOME/.asdf/asdf.sh"

# asdf
if type asdf >/dev/null 2>&1; then
    [ -f "$ASDF_DIR/plugins/java/set-java-home.zsh" ] && source "$ASDF_DIR/plugins/java/set-java-home.zsh"
fi

if type npm >/dev/null 2>&1; then
    export PATH="$(npm config get prefix)/bin:$PATH"
fi

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

[ -f "$HOME/.zlocal" ] && source "$HOME/.zlocal"
