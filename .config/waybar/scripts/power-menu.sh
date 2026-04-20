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
  ~/.config/hypr/scripts/hyprhook.sh off
  sudo sed -i "s/\(^ExecStart=\).*/\\1\\/sbin\\/agetty -a allisnull - \${TERM}/" /usr/lib/systemd/system/getty@.service
  echo s2idle | sudo tee /sys/power/mem_sleep
  hyprshutdown -t "Shutting down..." --post-cmd "systemctl poweroff"
  ;;
*Restart)
  ~/.config/hypr/scripts/hyprhook.sh off
  sudo sed -i "s/\(^ExecStart=\).*/\\1\\/sbin\\/agetty -a allisnull - \${TERM}/" /usr/lib/systemd/system/getty@.service
  echo s2idle | sudo tee /sys/power/mem_sleep
  hyprshutdown -t "Restarting..." --post-cmd "systemctl reboot"
  ;;
*Sleep)
  echo s2idle | sudo tee /sys/power/mem_sleep
  systemctl suspend
  ;;
*Logout)
  ~/.config/hypr/scripts/hyprhook.sh off
  loginctl kill-session "$XDG_SESSION_ID"
  ;;
*Stay\ Awake)
  pkill -x "hypridle"
  ;;
*Sleep\ on\ Idle)
  hypridle
  ;;
esac
