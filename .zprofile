#!/usr/bin/env zsh
# written by kensuke kubo

if [ "$(uname)" = "Linux" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    brew_prefix="$(brew --prefix)"
elif [ "$(uname)" = "Darwin" ]; then
    brew_prefix="/usr/local"
    export PATH="$brew_prefix/bin:$PATH"
fi

# goenv
export LIBRARY_PATH="$brew_prefix/opt/openssl/lib/:$LIBRARY_PATH"
export GOENV_GOPATH_PREFIX="$HOME/.go"

# phpenv
export PKG_CONFIG_PATH="$brew_prefix/opt/krb5/lib/pkgconfig:$brew_prefix/opt/icu4c/lib/pkgconfig:$brew_prefix/opt/libedit/lib/pkgconfig:$brew_prefix/opt/libjpeg/lib/pkgconfig:$brew_prefix/opt/libpng/lib/pkgconfig:$brew_prefix/opt/libxml2/lib/pkgconfig:$brew_prefix/opt/libzip/lib/pkgconfig:$brew_prefix/opt/oniguruma/lib/pkgconfig:$brew_prefix/opt/openssl@1.1/lib/pkgconfig:$brew_prefix/opt/tidy-html5/lib/pkgconfig:$PKG_CONFIG_PATH"
export PHP_BUILD_CONFIGURE_OPTS="\
 --with-openssl=/usr/local/opt/openssl \
 --with-bz2=/usr/local/opt/bzip2 \
 --with-iconv=/usr/local/opt/libiconv \
 --with-tidy=/usr/local/opt/tidy-html5 \
 --with-zlib \
 --with-zlib-dir=/usr/local/opt/zlib"

# shell
export GREP_OPTIONS="--color=auto"
export BAT_THEME=ansi-dark
export CLOUDSDK_PYTHON=python
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="$brew_prefix/share/zsh-syntax-highlighting/highlighters"

export PATH="$HOME/.anyenv/bin:$PATH"

export PATH="$GOROOT/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"

GHQ_ROOT="$(ghq root)"
export PATH="$GHQ_ROOT/github.com/flutter/flutter/bin/:$PATH"

eval "$(anyenv init -)"
