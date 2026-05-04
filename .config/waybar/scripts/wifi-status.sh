#!/usr/bin/env bash

if ! command -v nmcli &>/dev/null; then
    echo "{\"text\": \"󰤫\", \"tooltip\": \"nmcli utility is missing\"}"
    exit 1
fi

if ! nmcli -t general &>/dev/null 2>&1; then
    echo "{\"text\": \"󰤮\", \"tooltip\": \"NetworkManager unavailable\"}"
    exit 0
fi

wifi_status=$(nmcli -t radio wifi 2>/dev/null)

if [ "$wifi_status" = "disabled" ]; then
    echo "{\"text\": \"󰤮\", \"tooltip\": \"Wi-Fi Disabled\"}"
    exit 0
fi

wifi_info=$(nmcli -t -f active,ssid,signal,security dev wifi 2>/dev/null | grep "^yes")

if [ -z "$wifi_info" ]; then
    essid="No Connection"
    signal=0
    tooltip="No Connection"
else
    ip_address="127.0.0.1"
    security=$(echo "$wifi_info" | awk -F: '{print $4}')
    chan="N/A"
    signal=$(echo "$wifi_info" | awk -F: '{print $3}')

    active_device=$(nmcli -t -f DEVICE,STATE device status 2>/dev/null |
        grep -w "connected" |
        grep -v -E "^(dummy|lo:)" |
        awk -F: '{print $1}')

    if [ -n "$active_device" ]; then
        output=$(nmcli -e no -g ip4.address,ip4.gateway,general.hwaddr device show "$active_device" 2>/dev/null)

        ip_address=$(echo "$output" | sed -n '1p')

        line=$(nmcli -e no -t -f active,bssid,chan,freq device wifi 2>/dev/null | grep "^yes")

    chan=$(echo "$line" | awk -F':' '{print $8}')
    freq=$(echo "$line" | awk -F':' '{print $9}')
    chan="$chan ($freq)"

    essid=$(echo "$wifi_info" | awk -F: '{print $2}')

    tooltip=":: ${essid}"
    tooltip+="\nIP Address: ${ip_address}"
    tooltip+="\nSecurity:   ${security}"
    tooltip+="\nChannel:    ${chan}"
    tooltip+="\nStrength:   ${signal} / 100"

    fi
fi

if [ "$signal" -ge 80 ]; then
    icon="󰤨"
elif [ "$signal" -ge 60 ]; then
    icon="󰤥"
elif [ "$signal" -ge 40 ]; then
    icon="󰤢"
elif [ "$signal" -ge 20 ]; then
    icon="󰤟"
else
    icon="󰤯"
fi

# Module and tooltip
echo "{\"text\": \"${icon}\", \"tooltip\": \"${tooltip}\"}"
