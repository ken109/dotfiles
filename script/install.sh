#!/usr/bin/env bash

set -u

# Constants
DOTPATH="${DOTPATH:-$HOME/.dotfiles}"
DOTFILES_GITHUB="https://github.com/ken109/dotfiles.git"
TARBALL_URL="https://github.com/ken109/dotfiles/archive/master.tar.gz"

# Helpers
e_header() { printf " \033[37;1m%s\033[m\n" "$*"; }
e_error() { printf " \033[31m%s\033[m\n" "✖ $*" 1>&2; }
e_done() { printf " \033[37;1m%s\033[m...\033[32mOK\033[m\n" "✔ $*"; }

is_exists() {
  which "$1" >/dev/null 2>&1
  return $?
}

dotfiles_download() {
  if [ -d "$DOTPATH" ]; then
    e_error "$DOTPATH: already exists"
    return 1
  fi

  e_header "Downloading dotfiles..."

  if is_exists "git"; then
    git clone --recursive "$DOTFILES_GITHUB" "$DOTPATH"
  elif is_exists "curl" || is_exists "wget"; then
    if is_exists "curl"; then
      curl -L "$TARBALL_URL" | tar xvz
    elif is_exists "wget"; then
      wget -O - "$TARBALL_URL" | tar xvz
    fi
    mv -f dotfiles-master "$DOTPATH"
  else
    e_error "curl or wget required"
    exit 1
  fi

  e_done "Download"
}

dotfiles_initialize() {
  e_header "Initializing dotfiles..."
  if [ -f "$DOTPATH/script/setup" ]; then
    # Execute setup script
    "$DOTPATH/script/setup"
  else
    e_error "setup script not found"
    exit 1
  fi
  e_done "Initialize"
}

# shellcheck disable=SC2016
dotfiles_logo='
      | |     | |  / _(_) |
    __| | ___ | |_| |_ _| | ___  ___
   / _` |/ _ \| __|  _| | |/ _ \/ __|
  | (_| | (_) | |_| | | | |  __/\__ \
   \__,_|\___/ \__|_| |_|_|\___||___/
  *** WHAT IS INSIDE? ***
  1. Download https://github.com/ken109/dotfiles.git
  2. Execute sh files within `script/setup`
  See the README for documentation.
  https://github.com/ken109/dotfiles
'

dotfiles_install() {
  if [ -d "$DOTPATH" ]; then
      e_header "Dotfiles already downloaded at $DOTPATH"
      dotfiles_initialize
      exit 0
  fi
  
  e_header "$dotfiles_logo" # Display the logo here
  dotfiles_download
  dotfiles_initialize
}
# Execution guard
if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
  # Script is being sourced, do nothing
  return 0
fi

# Run install
dotfiles_install
