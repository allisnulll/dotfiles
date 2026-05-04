#!/usr/bin/env bash

REPO_DIR="$HOME/Vault"

if [[ ! -d "$REPO_DIR/.git" ]]; then
    echo "Error: Not a git repository: $REPO_DIR"
    exit 1
fi

if ! git -C "$REPO_DIR" diff --quiet || \
   ! git -C "$REPO_DIR" diff --cached --quiet || \
    [[ -n $(git -C "$REPO_DIR" ls-files --others --exclude-standard) ]]; then
    if [[ "$(nmcli networking connectivity)" == "full" ]]; then
        BRANCH=$(git -C "$REPO_DIR" rev-parse --abbrev-ref HEAD)
        git -C "$REPO_DIR" fetch
        if git -C "$REPO_DIR" log HEAD.."origin/$BRANCH" --oneline | grep -q .; then
            git -C "$REPO_DIR" stash
            git -C "$REPO_DIR" pull --rebase
            git -C "$REPO_DIR" stash apply
            git -C "$REPO_DIR" stash drop
        fi
    fi
    git -C "$REPO_DIR" add .
    git -C "$REPO_DIR" commit -m "Hourly Commit: $(date '+%Y-%m-%d-%a %H:%M:%S')"
    if [[ "$(nmcli networking connectivity)" == "full" ]]; then
        git -C "$REPO_DIR" push
    fi
else
    echo "No changes to commit."
    exit 0
fi
