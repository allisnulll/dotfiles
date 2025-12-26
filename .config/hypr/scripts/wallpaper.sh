#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
ACTIVE_MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')

if [[ $1 ]]; then
    WALLPAPER="$WALLPAPER_DIR/alucard.png"
else
    CURRENT_WALL=$(basename "$(hyprctl hyprpaper listloaded)")
    WALLPAPER=$(fd --type f . "$WALLPAPER_DIR" | rg -v "alucard.png|$CURRENT_WALL" | shuf -n 1)
fi

hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper wallpaper "$ACTIVE_MONITOR,$WALLPAPER"
