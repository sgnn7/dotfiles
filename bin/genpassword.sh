#!/bin/bash

genpasswd() {
    local l=$1
    [ "$l" == "" ] && l=$length
    tr -dc 'A-Za-z0-9_x\@\#\!\-\+\=\(\)\~\[\]\{\}.,;:' < /dev/urandom | head -c ${l} | xargs -0
}

length=16
if [ $# -ne 0 ]; then
  length=$1
fi

genpasswd $1
