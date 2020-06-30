#!/usr/local/bin/fish

set -x PATH $HOME/.anyenv/bin $PATH
eval (anyenv init - | source)

set -gx GOENV_GOPATH_PREFIX $HOME/.go

set -gx BAT_THEME 'ansi-dark'

set -gx PATH '$GOROOT/bin' $PATH
set -gx PATH '$GOPATH/bin' $PATH
set -gx PATH '$HOME/.composer/vendor/bin' $PATH
set -gx PATH '$HOME/.cargo/bin' $PATH

# google cloud sdk
set -gx CLOUDSDK_PYTHON 'python'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc'
