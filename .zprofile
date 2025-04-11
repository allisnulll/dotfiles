if uwsm check may-start; then
    exec uwsm start hyprland.desktop

    systemctl --user enable --now hyprpaper.service
    systemctl --user enable --now waybar.service
fi
