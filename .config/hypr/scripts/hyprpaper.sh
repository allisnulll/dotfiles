#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
WALLPAPER="$WALLPAPER_DIR/alucard.png"
CACHE_DIR="/tmp/hyprpaper"

if [[ $1 == start ]]; then
    mkdir -p "$CACHE_DIR"
    for monitor in $(hyprctl monitors -j | jq -r ".[] | .name"); do
        hyprctl hyprpaper wallpaper "$monitor,$WALLPAPER"
        echo "$WALLPAPER" > "$CACHE_DIR/$monitor"
    done

    exit
fi

ACTIVE_MONITOR=$(hyprctl monitors -j | jq -r ".[] | select(.focused == true) | .name")
CACHE_FILE="$CACHE_DIR/$ACTIVE_MONITOR"

if [[ $1 != default ]]; then
    WALLPAPER=$(fd --type f . "$WALLPAPER_DIR" | rg -v "alucard.png|$(cat "$CACHE_FILE")" | shuf -n 1)
fi

hyprctl hyprpaper wallpaper "$ACTIVE_MONITOR,$WALLPAPER"
echo "$WALLPAPER" > "$CACHE_FILE"
