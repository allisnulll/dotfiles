#!/usr/bin/env bash
# NOTE: Taken from https://github.com/gimslab/rofi-web-search

if [[ ${ROFI_RETV:-0} -eq 2 ]]; then
    xdg-open "https://www.duckduckgo.com/search?q=$@" > /dev/null 2>&1
    exit 0
fi
echo Search web... 
