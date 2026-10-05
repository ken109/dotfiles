# =======================================================
# tools initialization
# =======================================================

# 未インストールのツールがあってもプロンプトごと壊れないよう、
# aliases.zsh / functions.zsh と同じく存在チェックしてから読み込む。
(( ${+commands[starship]} )) && eval "$(starship init zsh)"
(( ${+commands[mise]} ))     && eval "$(mise activate zsh)"
(( ${+commands[fzf]} ))      && eval "$(fzf --zsh)"
(( ${+commands[zoxide]} ))   && eval "$(zoxide init zsh)"

# fzf --zsh が Ctrl-R に履歴検索を割り当てるので、atuin はその後に読んで上書きする。
# 上矢印は標準の履歴送りのままにしたいので外す。
(( ${+commands[atuin]} ))    && eval "$(atuin init zsh --disable-up-arrow)"

# .envrc をディレクトリごとに読み込む。フックを張らないと direnv は何もしない。
# .config/zed/settings.json の "load_direnv": "shell_hook" もこれに依存している。
(( ${+commands[direnv]} ))   && eval "$(direnv hook zsh)"
