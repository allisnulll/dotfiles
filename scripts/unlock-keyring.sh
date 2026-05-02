#!/bin/bash

export DISPLAY=:0
export XDG_RUNTIME_DIR=/run/user/$(id -u)

password=$(<"$HOME/.keyring_pass")
/usr/bin/gnome-keyring-daemon --unlock <<< "$password"
