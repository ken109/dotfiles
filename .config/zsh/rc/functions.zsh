# =======================================================
# functions
# =======================================================
if (( ${+commands[git]} )); then
    function git-branch-prune() {
        local branches
        branches=$(git branch --format "%(refname:short) %(upstream:track)" | grep "\[gone\]" | cut -d" " -f1)

        if [[ -n "$branches" ]]; then
            echo "$branches" | xargs -I{} git branch -d {}
        else
            echo "No branches to prune."
        fi
    }
fi

if (( ${+commands[ghq]} )); then
    function cdg() {
        local root="$(ghq root)"
        local repo

        repo=$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $root/{}/README.*")

        if [ -n "$repo" ]; then
            cd "$root/$repo"
        fi
    }
fi

function dotfiles() {
    local cmd="$1"
    local dotpath="$HOME/.dotfiles"

    case "$cmd" in
        list)
            "$dotpath/script/list"
            ;;
        update)
            if ! (
                cd "$dotpath" || exit 1
                git pull || exit 1
                "$dotpath/script/deploy" || exit 1
            ); then
                echo "dotfiles update: failed, shell not reloaded" >&2
                return 1
            fi
            exec zsh -l
            ;;
        *)
            echo "Usage: dotfiles {list|update}"
            ;;
    esac
}
