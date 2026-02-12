#!/usr/bin/env bash

SESSIONS=$(tmux ls -F "#{session_id}" | sort -nk2 -t"$")
CURRENT_SESSION=$(tmux display -p "#{session_id}")
if [[ $1 == p ]]; then
    TARGET=$(echo "$SESSIONS" | sed -n "/^$CURRENT_SESSION$/{x;p}; h")
    [[ -z $TARGET ]] && TARGET=$(echo "$SESSIONS" | tail -1)
else
    TARGET=$(echo "$SESSIONS" | sed -n "/^$CURRENT_SESSION$/{n;p}")
    [[ -z $TARGET ]] && TARGET=$(echo "$SESSIONS" | head -1)
fi

tmux switchc -t "$TARGET"
