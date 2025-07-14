#!/usr/bin/env bash

LOW_BATTERY_THRESHOLD=20
BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT0/capacity)
CHARGING_STATUS=$(cat /sys/class/power_supply/BAT0/status)

if [[ "$BATTERY_LEVEL" -le "$LOW_BATTERY_THRESHOLD" &&
      "$(($BATTERY_LEVEL % 5))" -eq 0 &&
      "$CHARGING_STATUS" != "Charging" ]]; then
    notify-send -u critical "Low Battery" "Battery level is at $BATTERY_LEVEL%!"
fi
