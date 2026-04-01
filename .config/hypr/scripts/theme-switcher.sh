#!/usr/bin/env bash

# ============================================================
# Noctra OS - Dynamic Theme Switcher
# ============================================================

# Define your wallpaper directory
WALL_DIR="$HOME/Pictures/wallpapers"

# 1. Check if the directory exists
if [ ! -d "$WALL_DIR" ]; then
    notify-send -u critical "Theme Error" "Directory $WALL_DIR does not exist."
    exit 1
fi

# 2. Use Rofi to select a wallpaper
# Lists all images, passes them to Rofi, and saves your selection
SELECTED=$(ls "$WALL_DIR" | grep -E '\.(jpg|jpeg|png|gif)$' | rofi -dmenu -p "󰸉 Wallpaper" -i)

# Exit if you press Escape or click away
if [ -z "$SELECTED" ]; then
    exit 0
fi

FULL_PATH="$WALL_DIR/$SELECTED"

# 3. Ensure the AWWW daemon is running, then apply the wallpaper
awww query || awww-daemon &
awww img "$FULL_PATH" \
    --transition-type wipe \
    --transition-angle 30 \
    --transition-step 90 \
    --transition-fps 60

# 4. Run the Matugen color pipeline (Forced Dark Mode)
matugen image "$FULL_PATH" -m dark -t scheme-tonal-spot --source-color-index 0

# 5. Reload the UI components
pkill -USR2 waybar

# 6. Reload Swaync css
swaync-client -rs

# 6. Send a native desktop notification with the new wallpaper as the icon
notify-send -i "$FULL_PATH" -t 2500 "Theme Applied" "Colors synced to $SELECTED"