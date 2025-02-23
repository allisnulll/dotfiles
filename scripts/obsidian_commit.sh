#!/bin/zsh

REPO_DIR="$HOME/Vault"

if [ ! -d "$REPO_DIR/.git" ]; then
    echo "Error: Not a git repository: $REPO_DIR"
    exit 1
fi

if git diff --quiet; then
    echo "No changes to commit."
    exit 0
else
    git -C "$REPO_DIR" add .
    git -C "$REPO_DIR" commit -m "Hourly Commit: $(date '+%Y-%m-%d-%a %H:%M:%S')" && \
    git -C "$REPO_DIR" push origin main
fi
