#!/usr/bin/env bash

config="$HOME/.config/rofi/power-menu.rasi"

if pgrep -x "hypridle" >/dev/null; then
    actions=$(echo -e "  Lock\n  Shutdown\n  Restart\n  Sleep\n  Logout\n  Stay Awake")
else
    actions=$(echo -e "  Lock\n  Shutdown\n  Restart\n  Sleep\n  Logout\n  Sleep on Idle")
fi

# Display logout menu
selected_option=$(echo -e "$actions" | rofi -dmenu -i -config "${config}" || pkill -x rofi)

# Perform actions based on the selected option
case "$selected_option" in
    *Lock)
        loginctl lock-session
        ;;
    *Shutdown)
        hyprshutdown -t "Shutting down..." --post-cmd "systemctl poweroff"
        ;;
    *Restart)
        hyprshutdown -t "Restarting..." --post-cmd "systemctl reboot"
        ;;
    *Sleep)
        systemctl suspend
        ;;
    *Logout)
        loginctl kill-session "$XDG_SESSION_ID"
        ;;
    *Stay\ Awake)
        pkill -x "hypridle"
        ;;
    *Sleep\ on\ Idle)
        hypridle
        ;;
esac
