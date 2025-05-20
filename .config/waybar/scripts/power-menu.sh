#!/usr/bin/env bash

config="$HOME/.config/rofi/power-menu.rasi"

actions=$(echo -e "  Lock\n  Shutdown\n  Restart\n  Sleep\n  Logout")

# Display logout menu
selected_option=$(echo -e "$actions" | rofi -dmenu -i -config "${config}" || pkill -x rofi)

# Perform actions based on the selected option
case "$selected_option" in
*Lock)
  ~/.config/gtklock/lock.sh
  ;;
*Shutdown)
  systemctl poweroff
  ;;
*Restart)
  systemctl reboot
  ;;
*Sleep)
  systemctl suspend
  ;;
*Logout)
  loginctl kill-session "$XDG_SESSION_ID"
  ;;
esac
