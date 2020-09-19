#!/bin/bash
#
#         _ _        _       _
#        (_) |      | |     | |
#  __   ___| |_ __ _| |  ___| |__
#  \ \ / / | __/ _` | | / __| '_ \
#   \ V /| | || (_| | |_\__ \ | | |
#    \_/ |_|\__\__,_|_(_)___/_| |_|
#
#

# PLATFORM is the environment variable that
# retrieves the name of the running platform
export PLATFORM

_TAB_="$(printf "\t")"
_SPACE_=' '
_BLANK_="${_SPACE_}${_TAB_}"
_IFS_="$IFS"

e_newline() {
    printf "\n"
}

e_header() {
    printf " \033[37;1m%s\033[m\n" "$*"
}

e_error() {
    printf " \033[31m%s\033[m\n" "✖ $*" 1>&2
}

e_warning() {
    printf " \033[31m%s\033[m\n" "$*"
}

e_done() {
    printf " \033[37;1m%s\033[m...\033[32mOK\033[m\n" "✔ $*"
}

e_arrow() {
    printf " \033[37;1m%s\033[m\n" "➜ $*"
}

ink() {
    if [ "$#" -eq 0 -o "$#" -gt 2 ]; then
        echo "Usage: ink <color> <text>"
        echo "Colors:"
        echo "  black, white, red, green, yellow, blue, purple, cyan, gray"
        return 1
    fi

    local open="\033["
    local close="${open}0m"
    local black="0;30m"
    local red="1;31m"
    local green="1;32m"
    local yellow="1;33m"
    local blue="1;34m"
    local purple="1;35m"
    local cyan="1;36m"
    local gray="0;37m"
    local white="$close"

    local text="$1"
    local color="$close"

    if [ "$#" -eq 2 ]; then
        text="$2"
        case "$1" in
        black | red | green | yellow | blue | purple | cyan | gray | white)
            eval color="\$$1"
            ;;
        esac
    fi

    printf "${open}${color}${text}${close}"
}

logging() {
    if [ "$#" -eq 0 -o "$#" -gt 2 ]; then
        echo "Usage: ink <fmt> <msg>"
        echo "Formatting Options:"
        echo "  TITLE, ERROR, WARN, INFO, SUCCESS"
        return 1
    fi

    local color=
    local text="$2"

    case "$1" in
    TITLE)
        color=yellow
        ;;
    ERROR | WARN)
        color=red
        ;;
    INFO)
        color=blue
        ;;
    SUCCESS)
        color=green
        ;;
    *)
        text="$1"
        ;;
    esac

    timestamp() {
        ink gray "["
        ink purple "$(date +%H:%M:%S)"
        ink gray "] "
    }

    timestamp
    ink "$color" "$text"
    echo
}

log_fail() {
    logging ERROR "$1" 1>&2
}

log_fail() {
    logging WARN "$1"
}

# is_exists returns true if executable $1 exists in $PATH
is_exists() {
    which "$1" >/dev/null 2>&1
    return $?
}

# is_debug returns true if $DEBUG is set
is_debug() {
    if [ "$DEBUG" = 1 ]; then
        return 0
    else
        return 1
    fi
}

# Dotfiles {{{1

# Set DOTPATH as default variable
if [ -z "${DOTPATH:-}" ]; then
    DOTPATH=~/.dotfiles
    export DOTPATH
fi

DOTFILES_GITHUB="https://github.com/ken109/dotfiles.git"
export DOTFILES_GITHUB

# shellcheck disable=SC1078,SC1079,SC2016
dotfiles_logo='
      | |     | |  / _(_) |
    __| | ___ | |_| |_ _| | ___  ___
   / _` |/ _ \| __|  _| | |/ _ \/ __|
  | (_| | (_) | |_| | | | |  __/\__ \
   \__,_|\___/ \__|_| |_|_|\___||___/
  *** WHAT IS INSIDE? ***
  1. Download https://github.com/ken109/dotfiles.git
  2. Symlinking dot files to your home directory
  3. Execute all sh files within `etc/init/` (optional)
  See the README for documentation.
  https://github.com/ken109/dotfiles
'

dotfiles_download() {
    if [ -d "$DOTPATH" ]; then
        log_fail "$DOTPATH: already exists"
        exit 1
    fi

    e_newline
    e_header "Downloading dotfiles..."

    if is_debug; then
        :
    else
        if is_exists "git"; then
            # --recursive equals to ...
            # git submodule init
            # git submodule update
            git clone --recursive "$DOTFILES_GITHUB" "$DOTPATH"

        elif is_exists "curl" || is_exists "wget"; then
            # curl or wget
            local tarball="https://github.com/ken109/dotfiles/archive/master.tar.gz"
            if is_exists "curl"; then
                curl -L "$tarball"

            elif is_exists "wget"; then
                wget -O - "$tarball"

            fi | tar xvz
            if [ ! -d dotfiles-master ]; then
                log_fail "dotfiles-master: not found"
                exit 1
            fi
            command mv -f dotfiles-master "$DOTPATH"

        else
            log_fail "curl or wget required"
            exit 1
        fi
    fi
    e_newline && e_done "Download"
}

dotfiles_deploy() {
    e_newline
    e_header "Deploying dotfiles..."

    if [ ! -d $DOTPATH ]; then
        log_fail "$DOTPATH: not found"
        exit 1
    fi

    cd "$DOTPATH"

    if is_debug; then
        :
    else
        if [ -d "$HOME/.config" ]; then
            mv -f ~/.config ~/.config.backup
        fi

        make deploy

        if [ -d "$HOME/.config.backup" ]; then
            mv ~/.config.backup/* ~/.config/
        fi
    fi &&
        e_newline && e_done "Deploy"
}

dotfiles_initialize() {
    read -p "Initialize[y,n]:" initialize
    if [ "$initialize" = "y" ]; then
        e_newline
        e_header "Initializing dotfiles..."

        if is_debug; then
            :
        else
            if [ -f Makefile ]; then
                #DOTPATH="$(dotpath)"
                #export DOTPATH
                #bash "$DOTPATH"/etc/init/init.sh
                make init
            else
                log_fail "Makefile: not found"
                exit 1
            fi
        fi &&
            e_newline && e_done "Initialize"
    fi
}

# A script for the file named "install"
dotfiles_install() {
    # 1. Download the repository
    # ==> downloading
    #
    # Priority: git > curl > wget
    dotfiles_download &&

        # 2. Deploy dotfiles to your home directory
        # ==> deploying
        dotfiles_deploy &&

        # 3. Execute all sh files within etc/init/
        # ==> initializing
        dotfiles_initialize
}

if echo "$-" | grep -q "i"; then
    # -> source a.sh
    VITALIZED=1
    export VITALIZED

    : return
else
    # three patterns
    # -> cat a.sh | bash
    # -> bash -c "$(cat a.sh)"
    # -> bash a.sh

    # -> bash a.sh
    if [ "$0" = "${BASH_SOURCE:-}" ]; then
        exit
    fi

    # -> cat a.sh | bash
    # -> bash -c "$(cat a.sh)"
    if [ -n "${BASH_EXECUTION_STRING:-}" ] || [ -p /dev/stdin ]; then
        # if already vitalized, skip to run dotfiles_install
        if [ "${VITALIZED:=0}" = 1 ]; then
            exit
        fi

        trap "e_error 'terminated'; exit 1" INT ERR
        echo "$dotfiles_logo"
        dotfiles_install

        # Restart shell if specified "bash -c $(curl -L {URL})"
        # not restart:
        #   curl -L {URL} | bash
        if [ -p /dev/stdin ]; then
            e_warning "Now continue with Rebooting your shell"
        else
            e_newline
            e_arrow "Restarting your shell..."
            exec "${SHELL:-/bin/zsh}" -l
        fi
    fi
fi

# __END__ {{{1
# vim:fdm=marker
