#!/usr/bin/env bash

# shell
read -r -p "Install languages? ( y, [n] ) " install_lang

if [ "$(uname)" = "Darwin" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

elif [ "$(uname)" = "Linux" ]; then
    mkdir -p ~/.linuxbrew
    curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ~/.linuxbrew

    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
fi

brew install tmux neovim git fzf exa bat ripgrep ghq fd
git config --global ghq.root ~/.ghq

if [ "$(uname)" = "Darwin" ]; then
    brew install trash git-flow ken109/tap/lcl gpg gawk

    # php build
    brew install autoconf automake bison freetype gd gettext icu4c krb5 libedit libiconv libjpeg libpng libxml2 libzip pkg-config re2c zlib

    brew tap homebrew/cask-fonts

    brew install --cask font-hack-nerd-font
elif [ "$(uname)" = "Linux" ]; then
    sudo apt update

    sudo apt install -y dirmngr gpg curl gawk

    # php build
    sudo apt install -y autoconf bison build-essential curl gettext git libgd-dev libcurl4-openssl-dev libedit-dev libicu-dev libjpeg-dev libmysqlclient-dev libonig-dev libpng-dev libpq-dev libreadline-dev libsqlite3-dev libssl-dev libxml2-dev libzip-dev openssl pkg-config re2c zlib1g-dev
fi


curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

brew install zsh zsh-completions zsh-autosuggestions zsh-syntax-highlighting

sudo bash -c "echo '$(brew --prefix)/bin/zsh' >> /etc/shells"
sudo chsh -s "$(brew --prefix)/bin/zsh" "$USER"

"$(brew --prefix)/opt/fzf/install"

# shellcheck source=/dev/null
[ -f ~/.zshenv ] && source ~/.zshenv


if [ "$install_lang" = "y" ]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1

    source "$HOME/.asdf/asdf.sh"

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    asdf plugin add golang
    asdf plugin add python
    asdf plugin add nodejs
    asdf plugin add php

    if [ "$(uname)" = "Darwin" ]; then
        # flutter
        ghq get flutter/flutter
    fi
fi
