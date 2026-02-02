#!/usr/bin/env bash

# Colors and Logging
e_newline() {
    printf "\n"
}

e_header() {
    printf " \033[37;1m%s\033[m\n" "$*"
}

e_error() {
    printf " \033[31m%s\033[m\n" "✖ $*" 1>&2
}

e_warning() {
    printf " \033[31m%s\033[m\n" "$*"
}

e_done() {
    printf " \033[37;1m%s\033[m...\033[32mOK\033[m\n" "✔ $*"
}

e_arrow() {
    printf " \033[37;1m%s\033[m\n" "➜ $*"
}

e_section() {
    local title="$*"
    local line="────────────────────────────────────────"
    printf "\n"
    printf " \033[35;1m%s\033[m\n" "$line"
    printf " \033[35;1m%s\033[m\n" "  $title"
    printf " \033[35;1m%s\033[m\n" "$line"
    printf "\n"
}

# Checks
is_exists() {
    which "$1" >/dev/null 2>&1
    return $?
}

has_command() {
    command -v "$1" >/dev/null 2>&1
}

configure_alacritty() {
    local dotpath="${DOTPATH:-$HOME/.dotfiles}"
    local os
    os="$(uname -s)"

    e_section "Alacritty Configuration"
    local zellij_path
    zellij_path=$(command -v zellij)

    if [ -n "$zellij_path" ]; then
        e_header "Setting Zellij path in alacritty.toml to $zellij_path..."
        local config_file="$dotpath/.config/alacritty/alacritty.toml"

        if [ "$os" = "Darwin" ]; then
            sed -i '' "s|program = \".*zellij\"|program = \"$zellij_path\"|" "$config_file"
        else
            sed -i "s|program = \".*zellij\"|program = \"$zellij_path\"|" "$config_file"
        fi
        e_done "Alacritty configured with absolute path"
    else
        e_warning "zellij not found, skipping Alacritty path configuration"
    fi
}

get_dotfiles() {
    local dotpath="${DOTPATH:-$HOME/.dotfiles}"
    local targets=(".config" ".gemini" ".zshenv")

    if [ "$(uname -s)" = "Darwin" ]; then
        targets+=(".hammerspoon")
    fi

    (
        cd "$dotpath" || return 1

        for target in "${targets[@]}"; do
            if [ -d "$target" ]; then
                fd -H -t f . "$target"
            elif [ -f "$target" ]; then
                echo "$target"
            fi
        done
    )
}
