#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
WALLPAPER="$WALLPAPER_DIR/alucard.png"

if [[ $1 == start ]]; then
    hyprctl hyprpaper preload "$WALLPAPER"
    for monitor in $(hyprctl monitors -j | jq -r ".[] | .name"); do
        hyprctl hyprpaper wallpaper "$monitor,$WALLPAPER"
    done

    exit
fi

ACTIVE_MONITOR=$(hyprctl monitors -j | jq -r ".[] | select(.focused == true) | .name")

if [[ $1 != default ]]; then
    CURRENT_WALLPAPER=$(basename "$(hyprctl hyprpaper listloaded)")
    WALLPAPER=$(fd --type f . "$WALLPAPER_DIR" | rg -v "alucard.png|$CURRENT_WALLPAPER" | shuf -n 1)
fi

hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper wallpaper "$ACTIVE_MONITOR,$WALLPAPER"
