#!/bin/bash
HOUR_12=$(( 10#$(date +%H) % 12 ))
ICONS=(󱑖 󱑋 󱑌 󱑍 󱑎 󱑏 󱑐 󱑑 󱑒 󱑓 󱑔 󱑕)
TIME=$(date +%H:%M)
echo "{\"text\": \" ${ICONS[$HOUR_12]} $TIME\"}"
