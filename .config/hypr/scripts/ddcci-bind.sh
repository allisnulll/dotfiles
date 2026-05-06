#!/usr/bin/env bash

for name_file in /sys/bus/i2c/devices/i2c-*/name; do
    if grep -q "AMDGPU DM" "$name_file" 2>/dev/null; then
        busnum=$(basename "$(dirname "$name_file")" | sed "s/i2c-//")
        
        if sudo i2cdetect -y "$busnum" 2>/dev/null | grep -qE "37|UU"; then
            echo "ddcci 0x37" | sudo tee "/sys/bus/i2c/devices/i2c-$busnum/new_device" > /dev/null 2>&1
            echo "Bound/verified ddcci on i2c-$busnum"
        fi
    fi
done
