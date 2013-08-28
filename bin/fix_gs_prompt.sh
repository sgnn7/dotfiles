#!/bin/bash

YELLOW="\[\033[0;33m\]"
NORMAL="\[\033[0m\]"

original_prompt="${PS1}"
modified_prompt="$(echo -n "${original_prompt}" | sed 's/\\\$ $//g')"

get_status(){
  suffix=""
  if [ -n "$UNDER_JHBUILD" ]; then
    suffix="-jh"
  fi

  ps auxwwe | grep "gnome-shell " | grep -v grep | grep jhbuild > /dev/null
  return_value=$?
  if [ $return_value -ne 0 ]; then
    echo -n "[sys$suffix]"
  else
    echo -n "[dev$suffix]"
  fi
}

export PS1="$YELLOW\$(get_status)$NORMAL$modified_prompt$ "
export PROMPT_COMMAND=""

