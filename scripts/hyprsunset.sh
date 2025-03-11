#!/bin/zsh

killall -q hyprsunset

current_hour=$(date +%H)

if [ "$current_hour" -ge 23 ] || [ "$current_hour" -le 6 ]; then
    hyprsunset -t 5000
else
    hyprsunset -t 6500
fi
