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
    # ヘッダー行(NR>1)を除き、1列目のセッション名だけを抜き出す
    local sessions=$(herdr session list 2>/dev/null | awk 'NR>1 {print $1}')

    local selection=$(
        { echo "[Create New Session]"; echo "$sessions"; } | \
            fzf --header "Herdr: Select session or create new" \
            --height 40% --reverse --exit-0
    )

    if [[ -z "$selection" ]]; then
        return
    fi

    if [[ "$selection" == "[Create New Session]" ]]; then
        echo -n "Enter new session name (leave blank for default): "
        read session_name
        if [[ -n "$session_name" ]]; then
            herdr --session "$session_name"
        else
            herdr
        fi
    else
        herdr session attach "$selection"
    fi
fi

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

. "$HOME/.local/share/../bin/env"
