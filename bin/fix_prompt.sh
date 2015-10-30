#!/bin/bash

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[0;34m\]"

BOLD_GREEN="\[\033[1;32m\]"
BOLD_BLUE="\[\033[1;34m\]"

NORMAL="\[\033[0m\]"

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_STATESEPARATOR="$RED"

# Don't show if we have a stash
unset GIT_PS1_SHOWSTASHSTATE
# We want our own colors
unset GIT_PS1_SHOWCOLORHINTS

export PROMPT_COMMAND="__git_ps1 \"$BOLD_GREEN\u@\h$NORMAL:$BOLD_BLUE\w$NORMAL\" \"\342\230\242 \" \"$YELLOW[%s$YELLOW]$NORMAL\""
