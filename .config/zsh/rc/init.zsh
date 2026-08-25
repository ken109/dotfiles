# =======================================================
# tools initialization
# =======================================================

# 未インストールのツールがあってもプロンプトごと壊れないよう、
# aliases.zsh / functions.zsh と同じく存在チェックしてから読み込む。
(( ${+commands[starship]} )) && eval "$(starship init zsh)"
(( ${+commands[sheldon]} ))  && eval "$(sheldon source)"
(( ${+commands[mise]} ))     && eval "$(mise activate zsh)"
(( ${+commands[fzf]} ))      && eval "$(fzf --zsh)"
(( ${+commands[zoxide]} ))   && eval "$(zoxide init zsh)"
