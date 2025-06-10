if uwsm check may-start; then
    exec uwsm start hyprland.desktop

    systemctl --user enable --now hyprpaper
    systemctl --user enable --now waybar
fi
