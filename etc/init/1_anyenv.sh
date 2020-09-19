#!/bin/bash

if [ "$(uname)" = "Darwin" ]; then
    echo y | anyenv install --init

    anyenv install pyenv
    anyenv install rbenv
    anyenv install goenv
    anyenv install nodenv
    anyenv install phpenv

    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"

    anaconda=$(pyenv install -l | grep anaconda3 | tail -n 1 | sed 's/ //g')
    pyenv install "$anaconda"
    pyenv global "$anaconda"

    conda_path="$(pyenv root)/versions/$anaconda/bin/conda"
    sed -i -e "/# >>> conda/,/# <<< conda/ s:eval.*:$conda_path shell.fish hook \$argv | source:g" ~/.config/fish/config.fish
fi
