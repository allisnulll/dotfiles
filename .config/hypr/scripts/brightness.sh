#!/usr/bin/env bash

step="5%+"
[ "$1" = down ] && step="5%-"

ddcci_devices=()
for dev in /sys/class/backlight/ddcci*/; do
    [ -d "$dev" ] && ddcci_devices+=("$(basename "$dev")")
done

if [ ${#ddcci_devices[@]} -gt 0 ]; then
    for dev in "${ddcci_devices[@]}"; do
        brightnessctl -d "$dev" set "$step"
    done
else
    ./ddcci-bind.sh
    brightnessctl set "$step"
fi
