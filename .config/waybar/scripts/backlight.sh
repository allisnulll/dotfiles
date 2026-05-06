#!/usr/bin/env bash

percent=$(brightnessctl -m 2>/dev/null | head -n 1 | awk -F',' '{print $4}' | tr -d '%')

if [ -z "$percent" ]; then
    echo '{"text": "", "tooltip": "No backlight"}'
    exit 0
fi

if ((percent <= 5)); then
    icon=$'\ue38d'
elif ((percent <= 15)); then
    icon=$'\ue3d3'
elif ((percent <= 30)); then
    icon=$'\ue3d1'
elif ((percent <= 45)); then
    icon=$'\ue3cf'
elif ((percent <= 55)); then
    icon=$'\ue3ce'
elif ((percent <= 65)); then
    icon=$'\ue3cd'
elif ((percent <= 80)); then
    icon=$'\ue3ca'
elif ((percent <= 95)); then
    icon=$'\ue3c8'
else
    icon=$'\ue39b'
fi

device=$(brightnessctl -m | head -n 1 | awk -F',' '{print $1}' | sed 's/_/ /g; s/\<./\U&/g')
cur=$(brightnessctl -m | head -n 1 | awk -F',' '{print $3}')
max=$(brightnessctl -m | head -n 1 | awk -F',' '{print $5}')

printf '{"text": "%s %s%%", "tooltip": "%s: %s/%s"}' "$icon" "$percent" "$device" "$cur" "$max"