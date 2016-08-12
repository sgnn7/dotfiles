export PATH=$PATH:~/bin

. fix_prompt.sh

export HISTSIZE=300000
export HISTFILESIZE=300000

# append to history
shopt -s histappend

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

export ANSIBLE_NOCOWS=1

alias cvm='ssh dev1@vm1'
alias cvm2='ssh dev1@vm2'
alias sus='sudo -u $USER -- gnome-screensaver-command -l && sudo pm-suspend'
alias ddst='ps -ef | grep dd | grep sudo | awk "{print \$2}" | xargs sudo kill -USR1'

alias br='byobu-layout restore rails'

# I make this mistake way too often
gi() {
  echo -e "\e[1;31m!!!Get your spelling in order!!!\e[0m"
  return 1
}

stty -ixon

setxkbmap -option ctrl:nocaps

# "Clear" our session ssh-agent. We don't want to send our keys to too many places.
# XXX: Don't forget to add `trap "ssh-agent -k" EXIT` to .bashrc since this shell exits
eval "$(ssh-agent)"
