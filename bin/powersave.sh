#!/bin/bash

if [ $EUID != 0 ]; then
  echo "Not root. Extiting"
  exit 1
fi

/sbin/modprobe cpufreq_ondemand > /dev/null 2>&1
#for cpu in /sys/devices/system/cpu/cpu?/cpufreq/scaling_governor; do echo 'ondemand' > $cpu; done
for cpu in /sys/devices/system/cpu/cpu?/cpufreq/scaling_governor; do echo 'powersave' > $cpu; done

echo '1' > '/sys/module/snd_hda_intel/parameters/power_save';
#echo '1' > /sys/devices/system/cpu/intel_pstate/no_turbo

iw dev wlan0 set power_save on
echo 'min_power' > '/sys/class/scsi_host/host4/link_power_management_policy';
echo 'min_power' > '/sys/class/scsi_host/host5/link_power_management_policy';
echo 'min_power' > '/sys/class/scsi_host/host2/link_power_management_policy';
echo 'min_power' > '/sys/class/scsi_host/host3/link_power_management_policy';
echo 'min_power' > '/sys/class/scsi_host/host0/link_power_management_policy';
echo 'min_power' > '/sys/class/scsi_host/host1/link_power_management_policy';
echo '1500' > '/proc/sys/vm/dirty_writeback_centisecs';
echo '0' > '/proc/sys/kernel/nmi_watchdog';
echo 'auto' > '/sys/bus/usb/devices/1-1.1/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:03:00.0/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:1a.0/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:1f.2/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:00.0/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:01.0/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:02.0/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:16.0/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:04:00.0/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:1f.3/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:1f.0/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:1d.0/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:1c.3/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:1c.0/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:1c.1/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:14.0/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:00:1b.0/power/control';
echo 'auto' > '/sys/bus/pci/devices/0000:01:00.0/power/control';
