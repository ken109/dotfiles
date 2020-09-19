#!/bin/bash

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
