#!/usr/bin/env bash

# NOTE: Started from https://github.com/enoren5/Hyprland-opacity-script

NOTIFY_TITLE="Hyprland Opacity"
LOG_FILE="/tmp/hypr_opacity_memory.log"
MEMORY_FILE="/tmp/hypr_opacity_memory.json"

OPACITY_STEP=0.05
MIN_OPACITY=0.1
MAX_OPACITY=1.0
DEFAULT_OPACITY=1.0

mkdir -p "$(dirname "$MEMORY_FILE")"
touch "$MEMORY_FILE"
[[ ! -s $MEMORY_FILE ]] && echo "{}" > "$MEMORY_FILE"

DIRECTION="$1"

ADDR=$(hyprctl activewindow -j | jq -r '.address')
[[ -z "$ADDR" || "$ADDR" == "null" ]] && notify-send "$NOTIFY_TITLE" "No active window found" && exit 1

CURRENT_OPACITY=$(cat "$MEMORY_FILE" | jq -r --arg addr "$ADDR" '.[$addr] // 1.0')

case "$DIRECTION" in
    increase)
        NEW_OPACITY=$(echo "$CURRENT_OPACITY + $OPACITY_STEP" | bc)
        (( $(echo "$NEW_OPACITY > $MAX_OPACITY" | bc -l) )) && NEW_OPACITY=$MAX_OPACITY
        ;;
    decrease)
        NEW_OPACITY=$(echo "$CURRENT_OPACITY - $OPACITY_STEP" | bc)
        (( $(echo "$NEW_OPACITY < $MIN_OPACITY" | bc -l) )) && NEW_OPACITY=$MIN_OPACITY
        ;;
    reset)
        NEW_OPACITY=$DEFAULT_OPACITY
        ;;
    *)
        notify-send "$NOTIFY_TITLE" "Usage: $0 --increase | --decrease | --reset"
        exit 1
        ;;
esac

echo "NEW_OPACITY: $NEW_OPACITY" >> $LOG_FILE
echo "ADDR: $ADDR" >> $LOG_FILE

BATCH=""
for PROP in alpha alphainactive alphafullscreen alphaoverride; do
    BATCH="$BATCH ; dispatch setprop address:$ADDR $PROP $NEW_OPACITY"
done

if [ "$(echo "$NEW_OPACITY != 1.0" | bc)" -eq 1 ]; then
    BATCH="$BATCH ; dispatch setprop address:$ADDR noblur true"
else
    BATCH="$BATCH ; dispatch setprop address:$ADDR noblur false"
fi

BATCH="$BATCH ; dispatch focuswindow address:$ADDR"

BATCH="${BATCH:2}"

echo "BATCH: $BATCH" >> $LOG_FILE
hyprctl --batch "$BATCH"
echo "Batch executed: $BATCH" >> $LOG_FILE

TMP=$(mktemp)
cat "$MEMORY_FILE" | jq --arg addr "$ADDR" --argjson val "$NEW_OPACITY" '. + {($addr): $val}' > "$TMP" && mv "$TMP" "$MEMORY_FILE"
