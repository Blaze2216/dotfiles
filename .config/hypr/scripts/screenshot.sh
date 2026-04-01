#!/usr/bin/env bash

# Noctra OS - Advanced Screenshot Script
# Usage: screenshot.sh [full|area]

DIR="$HOME/Pictures/Screenshots"
NAME="Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
PATH_FILE="$DIR/$NAME"

# Create directory if it doesn't exist
mkdir -p "$DIR"

if [ "$1" == "full" ]; then
    # Fullscreen
    grim "$PATH_FILE"
elif [ "$1" == "area" ]; then
    # Area selection (slurp)
    # The '|| exit' ensures we don't save a blank file if you hit Escape
    slurp_area=$(slurp) || exit
    grim -g "$slurp_area" "$PATH_FILE"
else
    echo "Usage: screenshot.sh [full|area]"
    exit 1
fi

# Copy to clipboard
cat "$PATH_FILE" | wl-copy --type image/png

# Send Notification with image icon
notify-send -i "$PATH_FILE" -a "Noctra OS" "Screenshot Captured" "Saved to ~/Pictures/Screenshots and copied to clipboard."