#!/usr/bin/env bash
# Watches your wallpaper directory and automatically triggers Matugen if a file is modified/added
inotifywait -m -e close_write,moved_to ~/Pictures/wallpapers |
while read -r directory events filename; do
    FULL_PATH="$directory$filename"
    
    # Only trigger on actual images
    if [[ "$FULL_PATH" =~ \.(jpg|jpeg|png|gif)$ ]]; then
        matugen image "$FULL_PATH" -m dark -t scheme-tonal-spot
        pkill -USR2 waybar
    fi
done
