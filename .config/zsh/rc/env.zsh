# =======================================================
# path
# =======================================================
if [[ "$(uname)" == "Darwin" ]]; then
    export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
elif [[ "$(uname)" == "Linux" ]]; then
    export SSH_AUTH_SOCK=~/.1password/agent.sock
fi

# Homebrew PATH initialization (must be early)
if [[ "$(uname)" = "Darwin" ]]; then
    if [[ -d /opt/homebrew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -d /usr/local/homebrew ]]; then # For older installations
        eval "$(/usr/local/homebrew/bin/brew shellenv)"
    fi
elif [[ "$(uname)" = "Linux" ]]; then
    if [[ -d /home/linuxbrew/.linuxbrew ]]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    elif [[ -d $HOME/.linuxbrew ]]; then
        eval "$($HOME/.linuxbrew/bin/brew shellenv)"
    fi
fi

# `brew shellenv` exports FPATH, which leaks a stale Cellar functions path into
# child shells across zsh upgrades (e.g. .../zsh/5.9 lingers after 5.9.1 lands).
# Make sure the running zsh's own functions dir is in fpath, prune dead entries,
# and stop FPATH from being exported so the stale value can't propagate again.
if [[ -d "${HOMEBREW_PREFIX}/share/zsh/functions" ]]; then
    fpath=("${HOMEBREW_PREFIX}/share/zsh/functions" $fpath)
fi
fpath=(${^fpath}(N))   # drop non-existent directories
typeset +x FPATH       # un-export so child shells recompute their own

export PATH="/usr/local/bin:$PATH"
# Ensure $HOME/.local/bin is in PATH after Homebrew, but before other tools
export PATH="$HOME/.local/bin:$PATH"

# local bin env (uv などが配置)
if [[ -f "$HOME/.local/bin/env" ]]; then
    . "$HOME/.local/bin/env"
fi

# rust env
if [[ -f "$HOME/.cargo/env" ]]; then
    . "$HOME/.cargo/env"
fi

# go env
if (( ${+commands[go]} )); then
    export GOPATH="$HOME/.go"
    export GO111MODULE=on

    if [[ -v GOROOT ]]; then
        export PATH="$GOROOT/bin:$PATH"
    fi
    export PATH="$GOPATH/bin:$PATH"
fi

# Vite+ bin (https://viteplus.dev)
if [[ -f "$HOME/.vite-plus/env" ]]; then
    . "$HOME/.vite-plus/env"
fi

# bun
if [[ -d "$HOME/.bun" ]]; then
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
fi
