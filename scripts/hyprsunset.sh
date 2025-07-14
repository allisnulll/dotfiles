#!/usr/bin/env zsh

killall -q hyprsunset

current_hour=$(date +%H)

if [ "$current_hour" -ge 21 ] || [ "$current_hour" -le 6 ]; then
    if [ "$current_hour" -ge 23 ] || [ "$current_hour" -le 4 ]; then
        hyprsunset -t 4000
    else
        hyprsunset -t 5000
    fi
else
    hyprsunset -t 6500
fi
