#!/usr/local/bin/fish

if [ (echo $TMUX) = "" ]
    if test (tmux list-sessions | wc -l) -eq 0
        tmux new-session
    else
        set ID (for i in (tmux list-sessions) 'create new session'; echo $i; end | fzf --reverse | cut -d: -f1)
        if [ (echo $ID) = "create new session" ]
            tmux new-session
        else if [ (echo $ID) != "" ]
            tmux attach-session -t $ID
        end
    end
end

source ~/.config/fish/env.fish
source ~/.config/fish/aliases.fish
source ~/.config/fish/Keybinds.fish
source ~/.config/fish/functions.fish
source ~/.config/fish/completions/*


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /Users/kensuke/.anyenv/envs/pyenv/versions/anaconda3-2020.02/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
