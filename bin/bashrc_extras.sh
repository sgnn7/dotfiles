export PATH=~/bin:$PATH

. fix_prompt.sh

alias cvm='ssh dev1@vm1'
alias cvm2='ssh dev1@vm2'
alias sus='sudo -u sg -- gnome-screensaver-command -l && sudo pm-suspend'
alias ddst='ps -ef | grep dd | grep sudo | awk "{print \$2}" | xargs sudo kill -USR1'

stty -ixon
