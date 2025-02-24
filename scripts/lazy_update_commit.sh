#!/bin/zsh

REPO_DIR="$HOME/.dotfiles"
TARGET_FILE="$REPO_DIR/.config/nvim/lazy-lock.json"

sleep 10

if [ ! -d "$REPO_DIR/.git" ]; then
    echo "Error: Not a git repository: $REPO_DIR"
    exit 1
fi

if git -C "$REPO_DIR" diff --quiet "$TARGET_FILE"; then
    echo "No changes to commit."
    exit 0
else
    git -C "$REPO_DIR" add "$TARGET_FILE"
    git -C "$REPO_DIR" commit -m "Lazy.nvim update at $(date '+%Y-%m-%d-%a %H:%M:%S')" && \
        git -C "$REPO_DIR" push origin main
fi
