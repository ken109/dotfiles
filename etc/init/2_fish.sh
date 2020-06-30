#!/bin/bash

brew install fish

sudo bash -c "echo '/usr/local/bin/fish' >> /etc/shells"
chsh -s /usr/local/bin/fish

curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

ghq get lgathy/google-cloud-sdk-fish-completion
source "$(ghq root)/github.com/lgathy/google-cloud-sdk-fish-completion/install.sh"
