#!/usr/bin/env bash

if [[ $1 ]]; then
    hyprctl hyprpaper reload ,"$HOME/Pictures/wallpapers/alucard.png"
    exit
fi

WALLPAPER_DIR="$HOME/Pictures/wallpapers/"
CURRENT_WALL=$(basename $(hyprctl hyprpaper listloaded))

WALLPAPER=$(fd --type f . $WALLPAPER_DIR | rg -v "alucard.png|$CURRENT_WALL" | shuf -n 1)

hyprctl hyprpaper reload ,$WALLPAPER
