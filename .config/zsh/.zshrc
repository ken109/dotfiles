#!/usr/bin/env zsh

local ZSH_CONFIG="${XDG_CONFIG_HOME}/zsh"

# Load configurations
source "$ZSH_CONFIG/rc/env.zsh"
source "$ZSH_CONFIG/rc/completion.zsh"
source "$ZSH_CONFIG/rc/init.zsh"
source "$ZSH_CONFIG/rc/options.zsh"
source "$ZSH_CONFIG/rc/aliases.zsh"
source "$ZSH_CONFIG/rc/functions.zsh"
source "$ZSH_CONFIG/rc/hooks.zsh"

# =======================================================
# local
# =======================================================

[ -f "$HOME/.zlocal" ] && source "$HOME/.zlocal"

# =======================================================
# run herdr
# =======================================================

if [[ "$ALACRITTY_WINDOW_ID" != "" && -z "$HERDR_ENV" && -z "$ZED_TERM" ]]; then
    # 常にdefaultセッションへアタッチ(なければ起動)。workspaceで分けて運用する
    herdr
fi
