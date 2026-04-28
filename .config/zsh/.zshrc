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
# run zellij
# =======================================================

if [[ "$ALACRITTY_WINDOW_ID" != "" && -z "$ZELLIJ" ]]; then
    local sessions=$(zellij list-sessions -n 2>/dev/null)

    local selection=$(
        { echo "[Create New Session]"; echo "$sessions"; } | \
            fzf --header "Zellij: Select session or create new" \
            --height 40% --reverse --exit-0
    )

    if [[ -z "$selection" ]]; then
        return
    fi

    if [[ "$selection" == "[Create New Session]" ]]; then
        echo -n "Enter new session name (leave blank for random): "
        read session_name
        if [[ -n "$session_name" ]]; then
            zellij -s "$session_name"
        else
            zellij
        fi
    else
        # 【重要】awk を使って、最初のスペースより前の「セッション名」だけを抜き出す
        # これにより "j-cat [Created...]" から "j-cat" だけが抽出されます
        local session_id=$(echo "$selection" | awk '{print $1}')
        zellij attach "$session_id"
    fi
fi

# bun completions
[ -s "/Users/ken109/.bun/_bun" ] && source "/Users/ken109/.bun/_bun"
