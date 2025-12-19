# =======================================================
# hooks
# =======================================================

autoload -Uz add-zsh-hook

function do_on_dir_change() {
  ls
}

add-zsh-hook chpwd do_on_dir_change

function zellij_tab_name_update() {
  if [[ -n $ZELLIJ ]]; then
    local current_dir="${PWD##*/}"
    if [[ "$PWD" == "$HOME" ]]; then
      current_dir="~"
    fi

    git_root=$(git rev-parse --show-toplevel 2>/dev/null)

    if [[ -n "$git_root" ]]; then
      local repo_name="${git_root##*/}"

      if [[ "$PWD" == "$git_root" ]]; then
        # リポジトリルートにいる時は、リポジトリ名だけ表示
        command zellij action rename-tab "$repo_name"
      else
        # サブディレクトリにいる時は、"ディレクトリ名 (リポジトリ名)" と表示
        command zellij action rename-tab "$current_dir ($repo_name)"
      fi
    else
      # Git管理外
      command zellij action rename-tab "$current_dir"
    fi
  fi
}

add-zsh-hook chpwd zellij_tab_name_update
zellij_tab_name_update
