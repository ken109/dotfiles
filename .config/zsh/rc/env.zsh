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

export PATH="/usr/local/bin:$PATH"
# Ensure $HOME/.local/bin is in PATH after Homebrew, but before other tools
export PATH="$HOME/.local/bin:$PATH"

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
