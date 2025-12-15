#!/usr/bin/env bash

# Colors and Logging
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

e_section() {
  local title="$*"
  local line="────────────────────────────────────────"
  printf "\n"
  printf " \033[35;1m%s\033[m\n" "$line"
  printf " \033[35;1m%s\033[m\n" "  $title"
  printf " \033[35;1m%s\033[m\n" "$line"
  printf "\n"
}

# Checks
is_exists() {
  which "$1" >/dev/null 2>&1
  return $?
}

has_command() {
  command -v "$1" >/dev/null 2>&1
}

get_dotfiles() {
  local dotpath="${DOTPATH:-$HOME/.dotfiles}"
  local exclusions=(".config" ".DS_Store" ".git" ".gitignore" ".idea" ".gemini" "Dockerfile" "Makefile" "README.md" "LICENSE" "openspec" "script")
  
  if [ "$(uname -s)" != "Darwin" ]; then
    exclusions+=(".hammerspoon")
  fi
  
  # Find candidates: .config subdirectories and dotfiles in root
  # Use a subshell to change directory without affecting the caller
  (
    cd "$dotpath" || return 1
    local candidates
    if [ -d ".config" ]; then
      candidates=$(find .config -mindepth 1 -maxdepth 1)
    else
      candidates=""
    fi
    candidates+=" $(find . -maxdepth 1 -name ".*" -not -name "." -not -name ".." | sed 's|^\./||')"
    
    for file in $candidates; do
      local skip=false
      for exclusion in "${exclusions[@]}"; do
        if [[ "$file" == "$exclusion" ]]; then
          skip=true
          break
        fi
      done
      
      if [[ "$skip" == "true" ]]; then
        continue
      fi
      
      echo "$file"
    done
  )
}
