#!/bin/bash

echo y | anyenv install --init

anyenv install pyenv
anyenv install rbenv
anyenv install goenv

anaconda=$(pyenv install -l | grep anaconda3 | tail -n 1 | sed 's/ //g')
pyenv install $anaconda
pyenv global $anaconda

coda_path="$(pyenv root)/versions/$anaconda/bin/conda"
sed -i -e "/# >>> conda/,/# <<< conda/ s/eval.*/1 $conda_path "shell.fish" "hook" \$argv | source/g" ~/.config/fish/config.fish
