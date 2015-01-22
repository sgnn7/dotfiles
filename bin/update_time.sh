#!/bin/bash
if [ $EUID != 0 ]; then
  echo "Need to be root to run this command"
  exit 1
fi

service ntp stop
ntpd -gq
service ntp start
