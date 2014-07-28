#!/bin/bash

if [ $# -gt 2 ]; then
  echo "Usage $0 <inc>"
fi

DEFAULT_CHANGE=-10 # Percent

backlight=/sys/class/backlight/*_backlight/
brightness_file=$backlight/brightness
max_brightness_file=$backlight/max_brightness

current_brightness=$(cat $brightness_file)
max_brightness=$(cat $max_brightness_file)

percent_brightness=$(( $current_brightness * 100 / $max_brightness ))

echo "$current_brightness of $max_brightness ($percent_brightness%)"

brightness_change=$DEFAULT_CHANGE
if [[ ${1} == "inc" ]]; then
  brightness_change=$(( - $brightness_change ))
fi

new_percent_brightness=$(($percent_brightness + $brightness_change))
new_brightness=$(($new_percent_brightness * $max_brightness / 100))

echo " -> $new_brightness"

echo "$new_brightness" | sudo tee $brightness_file
