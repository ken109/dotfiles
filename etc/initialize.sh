#!/usr/bin/env bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

if [ "$(uname)" = "Linux" ]; then
    echo "eval \"\$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)\"" >>"/home/$USER/.profile"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

brew install \
    tmux \
    neovim \
    git \
    fzf \
    exa \
    bat \
    ripgrep \
    fd

if [ "$(uname)" = "Darwin" ]; then
    brew install \
        trash \
        ghq \
        git-flow \
        anyenv \
        ken109/tap/lcl

    # php build
    brew install \
        pkg-config \
        krb5 \
        autoconf \
        mcrypt \
        openssl@1.1 \
        icu4c \
        bzip2 \
        oniguruma \
        tidy-html5 \
        libzip \
        libedit \
        libxml2 \
        libiconv \
        libpng \
        libjpeg

    brew cask install \
        docker

    git config --global ghq.root ~/.ghq
fi

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# shell
read -r -p "Select shell [zsh(default), fish] ? " shell

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
fi

# shellcheck source=/dev/null
[ -f ~/.zshenv ] && source ~/.zshenv

# anyenv
if [ "$(uname)" = "Darwin" ]; then
    echo y | anyenv install --init

    anyenv install pyenv
    anyenv install rbenv
    anyenv install goenv
    anyenv install nodenv
    anyenv install phpenv
    anyenv install plenv

    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"

    # pyenv
    anaconda_v="$(pyenv install -l | grep anaconda3 | tail -n 1 | sed 's/ //g')"
    pyenv install "$anaconda_v"
    pyenv global "$anaconda_v"
    conda init "$shell"

    # rbenv
    ruby_v="$(rbenv install --list-all | sed -n '/^[^a-z]*$/p' | tail -n 1 | sed -e 's/ //g')"
    rbenv install "$ruby_v"
    rbenv global "$ruby_v"

    # goenv
    go_v="$(goenv install -l | sed -n '/^[^a-z]*$/p' | tail -n 1 | sed -e 's/ //g')"
    goenv install "$go_v"
    goenv global "$go_v"

    # nodenv
    node_v="$(nodenv install -l | sed -n '/^[^a-z]*$/p' | tail -n 1 | sed -e 's/ //g')"
    nodenv install "$node_v"
    nodenv global "$node_v"

    # phpenv
    php_v="$(phpenv install -l | sed -n '/^[^a-z]*$/p' | tail -n 1 | sed -e 's/ //g')"
    phpenv install "$php_v"
    phpenv global "$php_v"

    # plenv
    perl_v="5.32.0"
    plenv install "$perl_v"
    plenv global "$perl_v"
fi
