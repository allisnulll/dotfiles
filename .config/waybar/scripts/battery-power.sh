#!/usr/bin/env bash

BAT_PATH=$(upower -e 2>/dev/null | grep BAT | head -n 1)

if [ -n "$BAT_PATH" ]; then
  STATE=$(upower -i "$BAT_PATH" | awk '/state:/ {print $2}')
  LEVEL=$(upower -i "$BAT_PATH" | awk '/percentage:/ {print $2}' | tr -d '%')

  ICONS=("󰂎" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")

  if [ "$STATE" = "charging" ] || [ "$STATE" = "fully-charged" ]; then
    CLASS="charging"
    TEXT=" ${LEVEL}%"
    TOOLTIP="Charging"
  else
    if [ "$LEVEL" -le 10 ]; then
      CLASS="critical"
    elif [ "$LEVEL" -le 20 ]; then
      CLASS="warning"
    else
      CLASS="discharging"
    fi

    IDX=$((LEVEL / 10))
    [ "$IDX" -gt 9 ] && IDX=9
    TEXT="${ICONS[$IDX]} ${LEVEL}%"
    TOOLTIP="Discharging"
  fi

  printf '{"text":"%s","tooltip":"%s","class":"%s"}' "$TEXT" "$TOOLTIP" "$CLASS"
else
  PJ="/tmp/powerjoular-service.csv"

  if [ -f "$PJ" ] && [ -s "$PJ" ]; then
    WATTS=$(tail -1 "$PJ" | awk -F',' '{printf "%.0f", $3}')

    PREV_FILE="/tmp/waybar-powerjoular-prev"
    ARROW="→"
    if [ -f "$PREV_FILE" ]; then
      PREV=$(cat "$PREV_FILE")
      if [ -n "$PREV" ]; then
        DIFF=$((WATTS - PREV))
        if [ "$DIFF" -gt 0 ]; then
          ARROW="<span foreground='#f38ba8'>↗</span>"
        elif [ "$DIFF" -lt 0 ]; then
          ARROW="<span foreground='#a6e3a1'>↘</span>"
        fi
      fi
    fi
    echo "$WATTS" > "$PREV_FILE"

    printf '{"text":" %sW %s ","tooltip":"Power Consumption: %sW","class":"power","markup":true}' "$WATTS" "$ARROW" "$WATTS"
  else
    printf '{"text":" --W ","tooltip":"Enable powerjoular: sudo systemctl enable --now powerjoular","class":"power"}'
  fi
fi
