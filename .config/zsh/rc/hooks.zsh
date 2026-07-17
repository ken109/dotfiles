# =======================================================
# hooks
# =======================================================

autoload -Uz add-zsh-hook

# -------------------------------------
# ls on chpwd (通常通り同期実行)
# -------------------------------------
function do_on_dir_change() {
    ls
}
add-zsh-hook chpwd do_on_dir_change

# -------------------------------------
# Herdr Tab Name Update (非同期実行)
# -------------------------------------
if [[ -n $HERDR_ENV ]]; then
    function _herdr_tab_name_update_logic() {
        local current_dir="${PWD##*/}"
        if [[ "$PWD" == "$HOME" ]]; then
            current_dir="~"
        fi

        local git_root
        git_root=$(git rev-parse --show-toplevel 2>/dev/null)

        if [[ -n "$git_root" ]]; then
            local repo_name="${git_root##*/}"

            if [[ "$PWD" == "$git_root" ]]; then
                command herdr tab rename "$HERDR_TAB_ID" "$repo_name"
            else
                command herdr tab rename "$HERDR_TAB_ID" "$current_dir ($repo_name)"
            fi
        else
            command herdr tab rename "$HERDR_TAB_ID" "$current_dir"
        fi
    }

    function herdr_tab_name_update() {
        _herdr_tab_name_update_logic &!
    }

    add-zsh-hook chpwd herdr_tab_name_update

    herdr_tab_name_update
fi
