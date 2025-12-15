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
