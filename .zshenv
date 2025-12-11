# homebrew
if [[ "$(uname)" = "Darwin" && -d /opt/homebrew ]]; then
    export HOMEBREW_PREFIX="/opt/homebrew";
    export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
    export HOMEBREW_REPOSITORY="/opt/homebrew";
    fpath[1,0]="/opt/homebrew/share/zsh/site-functions";
    eval "$(/usr/bin/env PATH_HELPER_ROOT="/opt/homebrew" /usr/libexec/path_helper -s)"
    [ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";
    export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
fi

# ghq
if type ghq >/dev/null 2>&1; then
    GHQ_ROOT="$(ghq root)"
fi

# asdf
if type asdf >/dev/null 2>&1; then
    export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fi

# rust env
if type rustup >/dev/null 2>&1; then
    export RUST_BACKTRACE=1
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# go env
if type go >/dev/null 2>&1; then
    export GOPATH="$HOME/.go"
    export GO111MODULE=on

    if [ -v GOROOT ]; then
        export PATH="$GOROOT/bin:$PATH"
    fi
    export PATH="$GOPATH/bin:$PATH"
fi
