#!/usr/bin/env bash

# shell
read -r -p "Select shell [ zsh(default), fish ] ? " shell
read -r -p "Install languages [ y, n(default) ] ? " install_lang

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

if [ "$(uname)" = "Linux" ]; then
    test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
fi

brew install \
    tmux \
    neovim \
    git \
    fzf \
    exa \
    bat \
    ripgrep \
    ghq \
    fd

git config --global ghq.root ~/.ghq

if [ "$(uname)" = "Darwin" ]; then
    brew install \
        trash \
        git-flow \
        ken109/tap/lcl

    # php build
    brew install \
        autoconf \
        automake \
        bison \
        freetype \
        gettext \
        icu4c \
        krb5 \
        libedit \
        libiconv \
        libjpeg \
        libpng \
        libxml2 \
        libzip \
        pkg-config \
        re2c \
        zlib

    brew tap homebrew/cask-fonts

    brew cask install \
        docker \
        font-hack-nerd-font
fi

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if [ "$shell" = "fish" ]; then
    # fish
    brew install fish

    sudo bash -c "echo '$(brew --prefix)/bin/fish' >> /etc/shells"
    sudo chsh -s "$(brew --prefix)/bin/fish" "$USER"

    curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

    if [ "$(uname)" = "Darwin" ]; then
        ghq get lgathy/google-cloud-sdk-fish-completion
        gcloud_completion="$(ghq root)/github.com/lgathy/google-cloud-sdk-fish-completion/"
        mkdir -p ~/.config/fish/completions/
        cp "$gcloud_completion/functions/*" "$HOME/.config/fish/functions/"
        cp "$gcloud_completion/completions/*" "$HOME/.config/fish/completions/"
    fi
else
    shell="zsh"
    brew install \
        zsh \
        zsh-completions \
        zsh-autosuggestions \
        zsh-syntax-highlighting

    sudo bash -c "echo '$(brew --prefix)/bin/zsh' >> /etc/shells"
    sudo chsh -s "$(brew --prefix)/bin/zsh" "$USER"

    "$(brew --prefix)/opt/fzf/install"

    # shellcheck source=/dev/null
    [ -f ~/.zshenv ] && source ~/.zshenv
fi

if [ "$install_lang" = "y" ]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0

    source "$HOME/.asdf/asdf.sh"

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    asdf plugin add golang
    asdf plugin add python
    asdf plugin add nodejs
    asdf plugin add php

    # flutter
    ghq get flutter/flutter
fi
