#!/usr/bin/env zsh
# written by kensuke kubo

if [ "$(uname)" = "Linux" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
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

GHQ_ROOT="$(ghq root)"

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
        --with-openssl=/usr/local/opt/openssl \
        --with-bz2=/usr/local/opt/bzip2 \
        --with-iconv=/usr/local/opt/libiconv \
        --with-tidy=/usr/local/opt/tidy-html5 \
        --with-zlib \
        --with-zlib-dir=/usr/local/opt/zlib"
fi

if [ "$(uname)" = "Darwin" ]; then
    export PATH="$GHQ_ROOT/github.com/flutter/flutter/bin/:$PATH"

    export CLOUDSDK_PYTHON=python
fi
