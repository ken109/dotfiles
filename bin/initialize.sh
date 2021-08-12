#!/usr/bin/env bash

# shell
read -r -p "Install Rust? ( y, [n] ) " install_rust

if [ "$(uname)" = "Darwin" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
source "$HOME/.asdf/asdf.sh"

if [ "$(uname)" = "Darwin" ]; then
  brew install zsh tmux neovim git fzf exa bat ripgrep ghq fd

  brew install trash git-flow ken109/tap/lcl gpg gawk

  # php build
  brew install autoconf automake bison freetype gd gettext icu4c krb5 libedit libiconv libjpeg libpng libxml2 libzip pkg-config re2c zlib

  brew tap homebrew/cask-fonts

  brew install --cask font-hack-nerd-font

  sudo bash -c "echo '$(brew --prefix)/bin/zsh' >> /etc/shells"
  sudo chsh -s "$(brew --prefix)/bin/zsh" "$USER"

  "$(brew --prefix)/opt/fzf/install"
elif [ "$(uname)" = "Linux" ]; then
  asdf plugin add golang
  go_version=$(asdf list all golang | rg '^[0-9]+\.[0-9]+\.[0-9]+$' | tail -1)
  asdf install golang "$go_version"
  asdf global golang "$go_version"

  go get github.com/x-motemen/ghq

  sudo apt update

  sudo apt install -y zsh tmux neovim git fzf exa bat ripgrep fd-find

  # nodejs
  sudo apt install -y dirmngr gpg curl gawk

  # php build
  sudo apt install -y autoconf bison build-essential curl gettext git libgd-dev libcurl4-openssl-dev libedit-dev libicu-dev libjpeg-dev libmysqlclient-dev libonig-dev libpng-dev libpq-dev libreadline-dev libsqlite3-dev libssl-dev libxml2-dev libzip-dev openssl pkg-config re2c zlib1g-dev

  sudo chsh -s "/usr/bin/zsh" "$USER"
fi

# ghq
git config --global ghq.root ~/.ghq

# nvim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"

git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

if [ "$install_rust" = "y" ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
