# =======================================================
# hooks
# =======================================================

autoload -Uz add-zsh-hook

function do_on_dir_change() {
  ls
}

# 3. 定義した関数を 'chpwd' フックに追加登録
add-zsh-hook chpwd do_on_dir_change
