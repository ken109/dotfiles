#!/usr/local/bin/fish

function set_pyenv
    set search ""
    set pyenv_name "main"
    for now in (string split '/' (pwd))[2..-1]
        set search (echo $search\/(string replace -a ' ' '' $now))
        if [ -f $search\/.python-version ]
            set pyenv_name (string replace -ra '[^/]*/[^/]+/' '' (cat $search\/.python-version))
        end
    end

    if [ $pyenv_name != "main" ]
        conda activate $pyenv_name
    else
        conda activate base
    end
end

function cd
    builtin cd $argv
    ls
    set_pyenv
end

function youtube-movie
    youtube-dl -f bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best $argv | grep ffmpeg | sed -e 's/.*"\(.*\)".*/\1/' | xargs -I% mv % ~/Downloads/
end

function youtube-audio
    youtube-dl -f bestaudio[ext=m4a] $argv | grep ffmpeg | sed -e 's/.*"\(.*\)".*/\1/' | xargs -I% mv % ~/Downloads/
end

function archive
    set area (for i in Ctag MyDev Univ; echo $i; end | fzf --height 40% --reverse)
    if [ (echo $area) = "" ];
        return
    end
    set dir (ls /Users/kensuke/GoogleDrive/$area | fzf --height 40% --reverse)
    if [ (echo $dir) = "" ];
        return
    end
    set now (pwd)
    if [ ! -e /Users/kensuke/GoogleDrive/Archive/$area ]
        mkdir /Users/kensuke/GoogleDrive/Archive/$area
    end
    builtin cd /Users/kensuke/GoogleDrive/$area
    tar acvf ../Archive/$area/$dir.tar.xz $dir
    trash $dir
    builtin cd $now
end
