#!/usr/bin/env bash

PANEL_SOCKET="/tmp/data-stream"
DATA_STREAMS="$HOME/Programming/Trading/data_streams"

if [ -S "$PANEL_SOCKET" ]; then
    kitten @ --to=unix:$PANEL_SOCKET resize-os-window --action=toggle-visibility
    exit 0
fi

kitten panel \
    --edge=background \
    --listen-on=unix:$PANEL_SOCKET \
    -o allow_remote_control=socket-only \
    sh -c "cd $DATA_STREAMS && python recent_trades.py" &

sleep 1

kitten @ --to=unix:$PANEL_SOCKET set-font-size 11
kitten @ --to=unix:$PANEL_SOCKET set-enabled-layouts horizontal
kitten @ --to=unix:$PANEL_SOCKET goto-layout horizontal
kitten @ --to=unix:$PANEL_SOCKET set-window-title "Recent Trades" --match=id:1
kitten @ --to=unix:$PANEL_SOCKET launch --cwd "$DATA_STREAMS" --title "Huge Trades" python huge_trades.py
kitten @ --to=unix:$PANEL_SOCKET launch --cwd "$DATA_STREAMS" --title "Funding" python funding.py
kitten @ --to=unix:$PANEL_SOCKET launch --cwd "$DATA_STREAMS" --title "Liquidations" python liqs.py
kitten @ --to=unix:$PANEL_SOCKET launch --cwd "$DATA_STREAMS" --title "Big Liquidations" python big_liqs.py
kitten @ --to=unix:$PANEL_SOCKET resize-window --match=id:3 --axis=horizontal --increment=-7
kitten @ --to=unix:$PANEL_SOCKET resize-window --match=id:5 --axis=horizontal --increment=-4
