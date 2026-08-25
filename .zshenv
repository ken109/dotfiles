#!/usr/bin/env zsh

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

if [[ "$OSTYPE" == darwin* ]]; then
    launchctl setenv XDG_CONFIG_HOME "$XDG_CONFIG_HOME"
    launchctl setenv XDG_CACHE_HOME "$XDG_CACHE_HOME"
    launchctl setenv XDG_DATA_HOME "$XDG_DATA_HOME"
    launchctl setenv XDG_STATE_HOME "$XDG_STATE_HOME"
fi

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# macOS のターミナルが SSH 越しに LC_CTYPE=UTF-8 を送ってくるが、
# glibc にその名前のロケールは無いため perl 等が警告を吐く。Linux 側で正規化する。
if [[ "$OSTYPE" != darwin* && "$LC_CTYPE" == "UTF-8" ]]; then
    export LC_CTYPE="${LANG:-C.UTF-8}"
fi
