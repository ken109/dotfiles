#!/usr/local/bin/fish

set -x PATH $HOME/.anyenv/bin $PATH
eval (anyenv init - | source)

# goenv
set -gx GOENV_GOPATH_PREFIX $HOME/.go
set -gx LIBRARY_PATH '/usr/local/opt/openssl/lib/' $LIBRARY_PATH

# phpenv
set -gx PKG_CONFIG_PATH "/usr/local/opt/openssl@1.1/lib/pkgconfig" $PKG_CONFIG_PATH
set -gx PKG_CONFIG_PATH "/usr/local/opt/krb5/lib/pkgconfig" $PKG_CONFIG_PATH
set -gx PKG_CONFIG_PATH "/usr/local/opt/icu4c/lib/pkgconfig" $PKG_CONFIG_PATH
set -gx PHP_BUILD_CONFIGURE_OPT "--with-bz2=/usr/local/opt/bzip2 --with-iconv=/usr/local/opt/libiconv"

set -gx BAT_THEME 'ansi-dark'

set -gx PATH '$GOROOT/bin' $PATH
set -gx PATH '$GOPATH/bin' $PATH
set -gx PATH '$HOME/.composer/vendor/bin' $PATH
set -gx PATH '$HOME/.cargo/bin' $PATH

# google cloud sdk
set -gx CLOUDSDK_PYTHON 'python'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc'
