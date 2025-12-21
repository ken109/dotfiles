#!/usr/bin/env zsh

# zmodload zsh/zprof && zprof

# Load configurations
source "$ZDOTDIR/rc/env.zsh"
source "$ZDOTDIR/rc/completion.zsh"
source "$ZDOTDIR/rc/init.zsh"
source "$ZDOTDIR/rc/options.zsh"
source "$ZDOTDIR/rc/aliases.zsh"
source "$ZDOTDIR/rc/functions.zsh"
source "$ZDOTDIR/rc/hooks.zsh"

# =======================================================
# local
# =======================================================

[ -f "$HOME/.zlocal" ] && source "$HOME/.zlocal"

# if (which zprof > /dev/null) ;then
#   zprof | less
# fi
