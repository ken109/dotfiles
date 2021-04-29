#!/usr/bin/env zsh

if [ "$(uname)" = "Linux" ]; then
    if [ -d /home/linuxbrew/.linuxbrew ]; then
        if [ "$(ls -la /home/linuxbrew/ | grep .linuxbrew | awk '{print $3}')" = "$USER" ]; then
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        fi
    fi
    [ -d ~/.linuxbrew ] && eval "$(~/.linuxbrew/bin/brew shellenv)"
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
