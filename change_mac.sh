#!/bin/bash

function get_mac {
  echo -n 00; hexdump -n 5 -v -e '/1 ":%02X"' /dev/urandom;
}

INTERFACES="eth0 wlan0"

for interface in $INTERFACES; do
    MAC=$(get_mac)
    echo "Changing $interface to MAC [$MAC]"
    sudo ifconfig $interface down
    sudo ifconfig $interface hw ether $MAC
    sudo ifconfig $interface up
done
exit 1

sudo service network-manager stop
sudo service network-manager start

ifconfig -a | grep HWaddr
