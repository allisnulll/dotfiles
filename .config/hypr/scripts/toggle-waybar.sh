#!/usr/bin/env bash

BAR_FILE=$HOME/.cache/waybar_disabled_ws
LWS_FILE=$HOME/.cache/last_ws
[ -f "$BAR_FILE" ] || echo "" > "$BAR_FILE"
[ -f "$LWS_FILE" ] || echo "" > "$LWS_FILE"

current_ws=$(hyprctl -j activeworkspace | jq ".id")

cws=$(grep -qw "$current_ws" "$BAR_FILE" && echo 1 || echo 0)
lws=$(grep -qw $(tail -n 1 "$LWS_FILE") "$BAR_FILE" && echo 1 || echo 0)

case "$1" in
    toggle)
        if [ "$cws" -eq 1 ]; then
            sed -i "/^$current_ws$/d" "$BAR_FILE"
        else
            echo "$current_ws" >> "$BAR_FILE"
        fi
        pkill -x -SIGUSR1 waybar
        ;;
    start)
        echo "" > "$BAR_FILE"
        echo 1 > "$LWS_FILE"
        ;;
    last)
        hyprctl dispatch workspace $(head -n 1 "$LWS_FILE")
        ;;
    *)
        if [ "$cws" -ne "$lws" ]; then
            pkill -x -SIGUSR1 waybar
        fi

        echo "$current_ws" >> "$LWS_FILE"
        tail -n 2 "$LWS_FILE" > "$LWS_FILE.tmp"
        mv "$LWS_FILE.tmp" "$LWS_FILE"
        ;;
esac
