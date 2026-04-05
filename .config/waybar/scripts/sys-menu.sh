#!/usr/bin/env bash

# Noctra OS - System Power Menu
SELECTION=$(echo -e "⏻  Shutdown\n⟳  Reboot\n⏾  Suspend\n  Lock\n󰍃  Logout" | rofi -dmenu -no-config -p "System" -theme-str '
    * { bg: #1e1e2e; fg: #cdd6f4; accent: #f38ba8; background-color: transparent; text-color: @fg; }
    window { width: 300px; background-color: @bg; border: 2px; border-color: @accent; border-radius: 12px; }
    mainbox { padding: 15px; }
    inputbar { enabled: false; }
    listview { lines: 5; spacing: 8px; fixed-height: true; }
    element { padding: 10px; border-radius: 8px; cursor: pointer; }
    element selected { background-color: #313244; text-color: @accent; }
')

# Execute the chosen action
case "$SELECTION" in
    *"Shutdown"*)
        systemctl poweroff
        ;;
    *"Reboot"*)
        systemctl reboot
        ;;
    *"Suspend"*)
        systemctl suspend
        ;;
    *"Lock"*)
        hyprlock # Change to swaylock if you use that instead
        ;;
    *"Logout"*)
        hyprctl dispatch exit
        ;;
esac
