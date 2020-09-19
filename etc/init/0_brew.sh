#!/bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew install \
    tmux \
    neovim \
    git \
    fzf \
    exa \
    bat \
    fd

if [ "$(uname)" = "Darwin" ]; then
    brew install \
        git-flow \
        anyenv \
        ghq \
        krb5 \
        openssl@1.1 \
        icu4c \
        libedit \
        libxml2 \
        bzip2 \
        libiconv \
        ken109/tap/lcl

    brew cask install \
        docker

    git config --global ghq.root ~/.ghq
fi

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
