if uwsm check may-start; then
	systemctl --user enable --now waybar.service
    exec uwsm start hyprland.desktop
fi
