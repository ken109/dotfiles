# =======================================================
# tools initialization
# =======================================================

eval "$(devbox global shellenv --init-hook)"
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"
eval "$(sheldon source)"
eval "$(mise activate zsh)"
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
