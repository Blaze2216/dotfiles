#!/usr/bin/env bash

# Ask Hyprland for the current layout string
CURRENT_LAYOUT=$(hyprctl getoption general:layout | grep 'str:' | awk '{print $2}')

if [ "$CURRENT_LAYOUT" = "dwindle" ]; then
    # Switch to Master
    hyprctl keyword general:layout master
    notify-send -i "view-list-symbolic" -t 2000 "Noctra OS" "Layout Engine: MASTER"
else
    # Switch to Dwindle
    hyprctl keyword general:layout dwindle
    notify-send -i "view-grid-symbolic" -t 2000 "Noctra OS" "Layout Engine: DWINDLE"
fi