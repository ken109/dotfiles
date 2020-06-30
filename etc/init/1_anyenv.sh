#!/bin/bash

echo y | anyenv install --init

anyenv install pyenv
anyenv install rbenv
anyenv install goenv

export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

anaconda=$(pyenv install -l | grep anaconda3 | tail -n 1 | sed 's/ //g')
pyenv install $anaconda
pyenv global $anaconda

conda_path="$(pyenv root)/versions/$anaconda/bin/conda"
sed -i -e "/# >>> conda/,/# <<< conda/ s/eval.*/$conda_path "shell.fish" "hook" \$argv | source/g" ~/.config/fish/config.fish
