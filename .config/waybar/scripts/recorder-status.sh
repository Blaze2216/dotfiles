#!/usr/bin/env bash

TIMESTAMP_FILE="/tmp/recording_start"

if pgrep -x "wf-recorder" > /dev/null; then
    if [ -f "$TIMESTAMP_FILE" ]; then
        START_TIME=$(cat "$TIMESTAMP_FILE")
        NOW=$(date +%s)
        ELAPSED=$((NOW - START_TIME))
        
        # Format seconds into MM:SS
        TIME_STR=$(date -d@$ELAPSED -u +%M:%S)
        
        # Output JSON for Waybar
        echo "{\"text\": \"󰑋 $TIME_STR\", \"class\": \"recording\", \"tooltip\": \"Recording in progress... Click to stop.\"}"
    else
        echo "{\"text\": \"󰑋 REC\", \"class\": \"recording\"}"
    fi
else
    # Output nothing if not recording
    echo ""
fi