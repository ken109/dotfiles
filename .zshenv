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
. "$HOME/.cargo/env"
