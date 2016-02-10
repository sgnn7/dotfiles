#!/bin/bash -e

# XXX: Assumes only one host-only net
iface_name=$(VBoxManage list -l hostonlyifs | grep '^Name:' | awk '{print $2}')

echo "Fixing '$iface_name'"
VBoxManage hostonlyif remove "${iface_name}" > /dev/null || true

VBoxManage hostonlyif create > /dev/null
VBoxManage hostonlyif ipconfig "${iface_name}" --ip 192.168.56.1

VBoxManage dhcpserver add --ifname "${iface_name}" --ip 192.168.56.1 \
                          --netmask 255.255.255.0 \
                          --lowerip 192.168.56.101 \
                          --upperip 192.168.56.110 &> /dev/null || true
VBoxManage dhcpserver modify --ifname "${iface_name}" --enable

echo "Done!"
