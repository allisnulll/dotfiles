#!/usr/bin/env zsh

if [[ $1 ]]; then
    hyprctl hyprpaper reload ,"$HOME/Pictures/wallpapers/alucard.png"
    exit
fi

WALLPAPER_DIR="$HOME/Pictures/wallpapers/"
CURRENT_WALL=$(hyprctl hyprpaper listloaded)

WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

hyprctl hyprpaper reload ,"$WALLPAPER"
