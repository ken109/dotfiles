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
# Zellij Tab Name Update (非同期実行)
# -------------------------------------
if [[ -n $ZELLIJ ]]; then
  function _zellij_tab_name_update_logic() {
    local current_dir="${PWD##*/}"
    if [[ "$PWD" == "$HOME" ]]; then
      current_dir="~"
    fi

    local git_root
    git_root=$(git rev-parse --show-toplevel 2>/dev/null)

    if [[ -n "$git_root" ]]; then
      local repo_name="${git_root##*/}"

      if [[ "$PWD" == "$git_root" ]]; then
        command zellij action rename-tab "$repo_name"
      else
        command zellij action rename-tab "$current_dir ($repo_name)"
      fi
    else
      command zellij action rename-tab "$current_dir"
    fi
  }

  function zellij_tab_name_update() {
    _zellij_tab_name_update_logic &!
  }

  add-zsh-hook chpwd zellij_tab_name_update

  zellij_tab_name_update
fi
