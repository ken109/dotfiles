#!/bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew install \
    tmux \
    neovim \
    anyenv \
    git \
    git-flow \
    fzf \
    exa \
    bat \
    fd \
    ghq \
    krb5 \
    openssl@1.1 \
    icu4c \
    libedit \
    libxml2 \
    bzip2 \
    libiconv

brew cask install \
    google-cloud-sdk

git config --global ghq.root ~/.ghq

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
