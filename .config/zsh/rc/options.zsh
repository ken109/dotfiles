# =======================================================
# zsh options
# =======================================================

setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt no_share_history

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000
export SAVEHIST=1000000

export BAT_THEME=ansi

setopt AUTO_CD

# shellcheck disable=SC2016
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -hl --icons --no-permissions --no-filesize --no-user --time-style=long-iso --group-directories-first --color=always $realpath'

zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' popup-min-size 200 0
