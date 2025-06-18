#!/bin/zsh

REPO_DIR="$HOME/Vault"

if [ ! -d "$REPO_DIR/.git" ]; then
    echo "Error: Not a git repository: $REPO_DIR"
    exit 1
fi

if ! git -C "$REPO_DIR" diff --quiet || \
   ! git -C "$REPO_DIR" diff --cached --quiet || \
   [ -n "$(git -C "$REPO_DIR" ls-files --others --exclude-standard)" ]; then
    git -C "$REPO_DIR" add .
    git -C "$REPO_DIR" commit -m "Hourly Commit: $(date '+%Y-%m-%d-%a %H:%M:%S')"
    if [[ "$(nmcli networking connectivity)" == "full" ]]; then
        git -C "$REPO_DIR" push
    fi
else
    echo "No changes to commit."
    exit 0
fi
