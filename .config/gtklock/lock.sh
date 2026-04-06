#!/usr/bin/env bash

for monitor in $(hyprctl monitors -j | jq -r '.[].name'); do
    grim -o "$monitor" "/tmp/lock-${monitor}.png"
    corrupter "/tmp/lock-${monitor}.png" "/tmp/lock-${monitor}.png"
done

cat ~/.config/gtklock/style.css > /tmp/gtklock-monitors.css

for monitor in $(hyprctl monitors -j | jq -r '.[].name'); do
    echo "
window#${monitor} {
    background-image: url(\"/tmp/lock-${monitor}.png\");
}" >> /tmp/gtklock-monitors.css
done

gtklock -d -c ~/.config/gtklock/config.ini -s /tmp/gtklock-monitors.css --follow-focus --idle-hide --idle-timeout 30