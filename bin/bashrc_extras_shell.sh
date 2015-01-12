export LIBGL_ALWAYS_SOFTWARE=y

export GNOME_SHELL_JS=$HOME/checkout/eos-shell/js

export DISPLAY=:0

alias dis='export DISPLAY=:0'

alias rr='nohup eos-shell --replace & 2&>1'
alias rrb='make && sudo make install && rr'

alias tt='killall tail | true && tail -f nohup.out &'

alias gitk='tig'
