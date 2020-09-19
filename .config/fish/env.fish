#!/usr/bin/env fish

set -x PATH $HOME/.anyenv/bin $PATH

# goenv
set -gx GOENV_GOPATH_PREFIX $HOME/.go
set -gx LIBRARY_PATH (brew --prefix)/opt/openssl/lib/ $LIBRARY_PATH

# phpenv
set -gx PKG_CONFIG_PATH (brew --prefix)/opt/openssl@1.1/lib/pkgconfig $PKG_CONFIG_PATH
set -gx PKG_CONFIG_PATH (brew --prefix)/opt/krb5/lib/pkgconfig $PKG_CONFIG_PATH
set -gx PKG_CONFIG_PATH (brew --prefix)/opt/icu4c/lib/pkgconfig $PKG_CONFIG_PATH
set -gx PHP_BUILD_CONFIGURE_OPT --with-bz2=(brew --prefix)/opt/bzip2 --with-iconv=(brew --prefix)/opt/libiconv

set -gx BAT_THEME ansi-dark

set -gx PATH $GOROOT/bin $PATH
set -gx PATH $GOPATH/bin $PATH
set -gx PATH $HOME/.composer/vendor/bin $PATH
set -gx PATH $HOME/.cargo/bin $PATH

# google cloud sdk
set -gx CLOUDSDK_PYTHON python
source (brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
