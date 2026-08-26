# =======================================================
# plugins
# =======================================================

# compinit より先に読む必要がある。
#
# zsh-completions のようなプラグインは fpath にディレクトリを足すだけで、
# 実際に補完関数を拾うのは compinit。順序が逆だと dump が作られた後に
# fpath が伸びるので、どの補完関数も autoload されないまま残る。
# 実際 zsh-completions の ~700 個は 1 つも効いていなかった。
#
# 逆に fzf / zoxide の初期化は compdef を呼ぶので compinit の後でなければ
# ならない。この 2 つの制約に挟まれてプラグインだけを分けている。
(( ${+commands[sheldon]} )) && eval "$(sheldon source)"
