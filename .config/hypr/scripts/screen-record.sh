#!/usr/bin/env bash

DIR="$HOME/Videos/Recordings"
NAME="Recording_$(date +%Y-%m-%d_%H-%M-%S).mp4"
PATH_FILE="$DIR/$NAME"
TIMESTAMP_FILE="/tmp/recording_start"

mkdir -p "$DIR"

# 1. If already recording, stop it
if pgrep -x "wf-recorder" > /dev/null; then
    pkill -INT wf-recorder
    rm "$TIMESTAMP_FILE"
    notify-send -a "Noctra OS" "Recording Stopped" "Video saved to $DIR" -i "video-x-generic"
    # Trigger Waybar update immediately
    pkill -RTMIN+8 waybar
    exit 0
fi

# 2. Start recording (Area or Full)
# Save the start time in seconds
date +%s > "$TIMESTAMP_FILE"

if [ "$1" == "area" ]; then
    slurp_area=$(slurp) || { rm "$TIMESTAMP_FILE"; exit 1; }
    notify-send -a "Noctra OS" "Recording Started" "Capturing area..." -t 2000
    wf-recorder -g "$slurp_area" -f "$PATH_FILE" &
else
    notify-send -a "Noctra OS" "Recording Started" "Capturing full screen..." -t 2000
    wf-recorder -f "$PATH_FILE" &
fi

# Trigger Waybar update
pkill -RTMIN+8 waybar