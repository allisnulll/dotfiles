#!/usr/bin/env zsh

PATCH_FILE="$HOME/.dotfiles/patches/graphite2qwerty.patch"
REPO_DIR="$HOME/.dotfiles"

if git -C "$REPO_DIR" apply --check -R "$PATCH_FILE" &>/dev/null; then
    git -C "$REPO_DIR" apply -R "$PATCH_FILE"
else
    git -C "$REPO_DIR" apply "$PATCH_FILE"
fi

hyprctl reload
tmux source-file "$HOME/.tmux.conf" && tmux display-message "Config reloaded!"
