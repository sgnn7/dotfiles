#!/bin/bash

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
NORMAL="\[\033[0m\]"
BLUE="\[\033[0;34m\]"

original_prompt="${PS1}"
modified_original_prompt=$(echo -n "${original_prompt}" | sed 's/\\\$ $//g')

dirty_indicator() {
  if [[ -n "$(git status 2> /dev/null | tail -n1)" ]]; then
    if [[ $(git status 2> /dev/null | tail -n1) != *"nothing to commit"* ]]; then
      echo -n "*"
    fi
  fi 
}

git_branch() {
  branch=`git branch 2>/dev/null | grep '^\*\ ' | awk '{print $2}'`
  echo -n "${branch}"
}

spacer_start() {
  if [[ -n "$(git status 2> /dev/null | tail -n1)" ]]; then
    echo -n "["
  fi
}

spacer_end() {
  if [[ -n "$(git status 2> /dev/null | tail -n1)" ]]; then
    echo -n "]"
  fi
}

export PS1="$modified_original_prompt$YELLOW\$(spacer_start)\$(git_branch)$RED\$(dirty_indicator)$YELLOW\$(spacer_end)$NORMAL$ "
export PROMPT_COMMAND=""
