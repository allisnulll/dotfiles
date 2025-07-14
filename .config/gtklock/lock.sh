#!/usr/bin/env zsh
grim /tmp/lock.png
corrupter /tmp/lock.png /tmp/lock.png
gtklock -dc ~/.config/gtklock/config.ini -s ~/.config/gtklock/style.css --idle-hide --idle-timeout 30
