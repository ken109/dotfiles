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
    fd

brew cask install \
    google-cloud-sdk
