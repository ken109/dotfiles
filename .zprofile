#!/usr/bin/env zsh

if [ "$(uname)" = "Linux" ]; then
    test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
    brew_prefix="$(brew --prefix)"
elif [ "$(uname)" = "Darwin" ]; then
    brew_prefix="/usr/local"
    export PATH="$brew_prefix/bin:$PATH"
fi

if type anyenv >/dev/null 2>&1; then
    eval "$(anyenv init -)"

    export PATH="$HOME/.anyenv/bin:$PATH"
fi

# shell
export BAT_THEME=ansi-dark
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="$brew_prefix/share/zsh-syntax-highlighting/highlighters"

if type ghq >/dev/null 2>&1; then
    GHQ_ROOT="$(ghq root)"

    if [ "$(uname)" = "Darwin" ]; then
        export PATH="$GHQ_ROOT/github.com/flutter/flutter/bin/:$PATH"
    fi
fi

# goenv
if type goenv >/dev/null 2>&1; then
    export LIBRARY_PATH="$brew_prefix/opt/openssl/lib/:$LIBRARY_PATH"
    export GOENV_DISABLE_GOPATH=1
    export GOPATH="$HOME/.go"
    export GO111MODULE=on

    export PATH="$GOROOT/bin:$PATH"
    export PATH="$GOPATH/bin:$PATH"
fi

# phpenv
if type phpenv >/dev/null 2>&1; then
    export PKG_CONFIG_PATH="$brew_prefix/opt/krb5/lib/pkgconfig:$brew_prefix/opt/icu4c/lib/pkgconfig:$brew_prefix/opt/libedit/lib/pkgconfig:$brew_prefix/opt/libjpeg/lib/pkgconfig:$brew_prefix/opt/libpng/lib/pkgconfig:$brew_prefix/opt/libxml2/lib/pkgconfig:$brew_prefix/opt/libzip/lib/pkgconfig:$brew_prefix/opt/oniguruma/lib/pkgconfig:$brew_prefix/opt/openssl@1.1/lib/pkgconfig:$brew_prefix/opt/tidy-html5/lib/pkgconfig:$PKG_CONFIG_PATH"
    export PHP_BUILD_CONFIGURE_OPTS="\
        --with-openssl=$brew_prefix/opt/openssl \
        --with-bz2=$brew_prefix/opt/bzip2 \
        --with-iconv=$brew_prefix/opt/libiconv \
        --with-tidy=$brew_prefix/opt/tidy-html5 \
        --with-zlib \
        --with-zlib-dir=$brew_prefix/opt/zlib"
fi

if [ "$(uname)" = "Darwin" ]; then
    export CLOUDSDK_PYTHON=python
fi
