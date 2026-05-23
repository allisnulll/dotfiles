#!/usr/bin/env bash

set -euo pipefail

OUTPUT_FILE="/tmp/powerjoular-service.csv"
TEMP_FILE="/tmp/powerjoular-raw.csv"

cleanup() {
    if [[ -n "${PJOUL_PID:-}" ]]; then
        kill "$PJOUL_PID" 2>/dev/null || true
        wait "$PJOUL_PID" 2>/dev/null || true
    fi
    rm -f "$TEMP_FILE"
}
trap cleanup EXIT INT TERM

gpu_sensors=()
for hwmon in /sys/class/hwmon/hwmon*; do
    if [[ "$(cat "$hwmon/name" 2>/dev/null)" == "amdgpu" ]]; then
        if [[ -f "$hwmon/power1_average" ]]; then
            gpu_sensors+=("$hwmon/power1_average")
        elif [[ -f "$hwmon/power1_input" ]]; then
            gpu_sensors+=("$hwmon/power1_input")
        fi
    fi
done

/usr/bin/powerjoular -o "$TEMP_FILE" &
PJOUL_PID=$!

sleep 2

while true; do
    if ! kill -0 "$PJOUL_PID" 2>/dev/null; then
        exit 1
    fi

    last_line=$(tail -1 "$TEMP_FILE" 2>/dev/null || true)
    if [[ -z "$last_line" ]]; then
        sleep 1
        continue
    fi

    if [[ "$last_line" == Date* ]]; then
        sleep 1
        continue
    fi

    cpu_util=$(echo "$last_line" | cut -d',' -f2)
    cpu_power=$(echo "$last_line" | cut -d',' -f3)

    total_gpu_uw=0
    for sensor in "${gpu_sensors[@]}"; do
        val=$(cat "$sensor" 2>/dev/null || echo 0)
        total_gpu_uw=$((total_gpu_uw + val))
    done

    result=$(awk -v cpu="$cpu_power" -v gpu_uw="$total_gpu_uw" '
        BEGIN {
            gpu_w = gpu_uw / 1000000
            total = cpu + gpu_w
            printf "%.14f,%.14f", total, gpu_w
        }
    ')

    total_power=$(echo "$result" | cut -d',' -f1)
    gpu_power=$(echo "$result" | cut -d',' -f2)

    timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    printf '%s,%s,%s,%s,%s\n' \
        "$timestamp" "$cpu_util" "$total_power" "$cpu_power" "$gpu_power" \
        > "$OUTPUT_FILE"

    sleep 1
done