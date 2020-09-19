#!/usr/bin/env fish

if [ (uname) = "Linux" ]
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)

    if [ (echo "$TMUX") = "" ]
        if test (tmux list-sessions | wc -l) -eq 0
            tmux new-session \; source-file $HOME/.config/tmux/window.conf
        else
            set ID (for i in (tmux list-sessions) 'create new session'; echo $i; end | fzf --reverse | cut -d: -f1)
            if [ (echo $ID) = "create new session" ]
                tmux new-session \; source-file $HOME/.config/tmux/window.conf
            else if [ (echo $ID) != "" ]
                tmux attach-session -t $ID
            end
        end
    end
else if [ (uname) = "Darwin" ]
    eval (anyenv init - | source)
end

source $HOME/.config/fish/env.fish
source $HOME/.config/fish/aliases.fish
source $HOME/.config/fish/Keybinds.fish
source $HOME/.config/fish/functions.fish

set fish_completions $HOME/.config/fish/completions/*
if count $fish_completions > /dev/null
    source $HOME/.config/fish/completions/*
end
