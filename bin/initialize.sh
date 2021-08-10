#!/usr/bin/env bash

# shell
read -r -p "Install Rust? ( y, [n] ) " install_rust

if [ "$(uname)" = "Darwin" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
source "$HOME/.asdf/asdf.sh"

asdf plugin add golang
asdf plugin add python
asdf plugin add nodejs
asdf plugin add php

if [ "$(uname)" = "Darwin" ]; then
  brew install tmux neovim git fzf exa bat ripgrep ghq fd

  brew install trash git-flow ken109/tap/lcl gpg gawk

  # php build
  brew install autoconf automake bison freetype gd gettext icu4c krb5 libedit libiconv libjpeg libpng libxml2 libzip pkg-config re2c zlib

  brew tap homebrew/cask-fonts

  brew install --cask font-hack-nerd-font

  brew install zsh zsh-completions zsh-autosuggestions zsh-syntax-highlighting

  sudo bash -c "echo '$(brew --prefix)/bin/zsh' >> /etc/shells"
  sudo chsh -s "$(brew --prefix)/bin/zsh" "$USER"

  "$(brew --prefix)/opt/fzf/install"

elif [ "$(uname)" = "Linux" ]; then
  asdf install golang 1.16.7
  go get github.com/x-motemen/ghq

  sudo apt update

  sudo apt install -y tmux neovim git fzf exa bat ripgrep fd-find

  # nodejs
  sudo apt install -y dirmngr gpg curl gawk

  # php build
  sudo apt install -y autoconf bison build-essential curl gettext git libgd-dev libcurl4-openssl-dev libedit-dev libicu-dev libjpeg-dev libmysqlclient-dev libonig-dev libpng-dev libpq-dev libreadline-dev libsqlite3-dev libssl-dev libxml2-dev libzip-dev openssl pkg-config re2c zlib1g-dev

  sudo chsh -s "/usr/bin/zsh" "$USER"
fi

git config --global ghq.root ~/.ghq

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if [ "$install_rust" = "y" ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
