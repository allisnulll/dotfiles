#!/usr/bin/env bash

step="5%+"
[ "$1" = down ] && step="5%-"

has_ddcci5=false
has_ddcci6=false
[ -d /sys/class/backlight/ddcci5 ] && has_ddcci5=true
[ -d /sys/class/backlight/ddcci6 ] && has_ddcci6=true

if $has_ddcci5 || $has_ddcci6; then
    $has_ddcci5 && brightnessctl -d ddcci5 set "$step"
    $has_ddcci6 && brightnessctl -d ddcci6 set "$step"
else
    brightnessctl set "$step"
fi
