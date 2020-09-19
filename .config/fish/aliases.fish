#!/usr/bin/env fish

alias ls 'exa'
alias la 'exa -a'
alias ll 'exa -hlg --git --time-style long-iso'
alias lla 'ls -hlga --git --time-style long-iso'

alias vim 'nvim'
alias rm 'trash'

alias rdns 'sudo killall -HUP mDNSResponder'

alias cdg 'cd (ghq root)/(ghq list | fzf)'
alias fco 'git checkout (git branch -a | tr -d " " |fzf --reverse --height 100% --prompt "CHECKOUT BRANCH>" --preview "git glog --color=always {}" | head -n 1 | sed -e "s/^\*\s*//g" | perl -pe "s/remotes\/origin\///g")'
