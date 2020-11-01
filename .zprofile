#!/usr/bin/env zsh
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.anyenv/bin:$PATH"
export PATH="$GOROOT/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"

# goenv
LIBRARY_PATH="$(brew --prefix)/opt/openssl/lib/:$LIBRARY_PATH"
export LIBRARY_PATH
export GOENV_GOPATH_PREFIX="$HOME/.go"

# phpenv
PKG_CONFIG_PATH="$(brew --prefix)/opt/openssl@1.1/lib/pkgconfig:$PKG_CONFIG_PATH"
PKG_CONFIG_PATH="$(brew --prefix)/opt/krb5/lib/pkgconfig:$PKG_CONFIG_PATH"
PKG_CONFIG_PATH="$(brew --prefix)/opt/icu4c/lib/pkgconfig:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH
export PHP_BUILD_CONFIGURE_OPT --with-bz2="$(brew --prefix)/opt/bzip2" --with-iconv="$(brew --prefix)/opt/libiconv"

# shell
export BAT_THEME=ansi-dark
export CLOUDSDK_PYTHON=python

# shellcheck source=/dev/null
[ -f ~/.zshrc ] && source ~/.zshrc
