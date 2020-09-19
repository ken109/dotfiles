#!/bin/bash

sudo su

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

# anyenv
if [ "$(uname)" = "Darwin" ]; then
    echo y | anyenv install --init

    anyenv install pyenv
    anyenv install rbenv
    anyenv install goenv
    anyenv install nodenv
    anyenv install phpenv

    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"

    anaconda=$(pyenv install -l | grep anaconda3 | tail -n 1 | sed 's/ //g')
    pyenv install "$anaconda"
    pyenv global "$anaconda"

    conda_path="$(pyenv root)/versions/$anaconda/bin/conda"
    sed -i -e "/# >>> conda/,/# <<< conda/ s:eval.*:$conda_path shell.fish hook \$argv | source:g" ~/.config/fish/config.fish
fi

# fish
brew install fish

sudo bash -c "echo '/usr/local/bin/fish' >> /etc/shells"
chsh -s /usr/local/bin/fish

curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

if [ "$(uname)" = "Darwin" ]; then
    ghq get lgathy/google-cloud-sdk-fish-completion
    gcloud_completion="$(ghq root)/github.com/lgathy/google-cloud-sdk-fish-completion/"
    mkdir -p ~/.config/fish/completions/
    cp "$gcloud_completion/functions/*" "$HOME/.config/fish/functions/"
    cp "$gcloud_completion/completions/*" "$HOME/.config/fish/completions/"
fi
