# =======================================================
# tools initialization
# =======================================================

# 未インストールのツールがあってもプロンプトごと壊れないよう、
# aliases.zsh / functions.zsh と同じく存在チェックしてから読み込む。
(( ${+commands[starship]} )) && eval "$(starship init zsh)"
(( ${+commands[mise]} ))     && eval "$(mise activate zsh)"
(( ${+commands[fzf]} ))      && eval "$(fzf --zsh)"
(( ${+commands[zoxide]} ))   && eval "$(zoxide init zsh)"

# .envrc をディレクトリごとに読み込む。フックを張らないと direnv は何もしない。
# .config/zed/settings.json の "load_direnv": "shell_hook" もこれに依存している。
(( ${+commands[direnv]} ))   && eval "$(direnv hook zsh)"
