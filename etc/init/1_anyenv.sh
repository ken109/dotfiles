#!/bin/bash

echo y | anyenv install --init

anyenv install pyenv
anyenv install rbenv
anyenv install goenv

anaconda=$(pyenv install -l | grep anaconda3 | tail -n 1 | sed 's/ //g')
pyenv install $anaconda
pyenv global $anaconda

anaconda=""
sed -ri -e '/# >>> conda/,/# <<< conda/ s/eval.*/$anaconda/g' ~/.config/fish/config.fish
