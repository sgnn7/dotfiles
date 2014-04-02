export PATH=~/bin:$PATH

. fix_prompt.sh

export HISTSIZE=100000
export HISTFILESIZE=100000

# append to history
shopt -s histappend

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

alias cvm='ssh dev1@vm1'
alias cvm2='ssh dev1@vm2'
alias sus='sudo -u $USER -- gnome-screensaver-command -l && sudo pm-suspend'
alias ddst='ps -ef | grep dd | grep sudo | awk "{print \$2}" | xargs sudo kill -USR1'

alias br='byobu-layout restore rails'

stty -ixon
