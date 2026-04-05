#!/usr/bin/env bash

# Pop up a minimalist Rofi menu for TuneD Profiles
SELECTION=$(echo -e "⚡ Throughput Performance\n⚖️ Balanced\n🔋 Power Saver\n💻 Laptop AC Powersave" | rofi -dmenu -no-config -p "TuneD" -theme-str '
    * { bg: #1e1e2e; fg: #cdd6f4; accent: #89b4fa; background-color: transparent; text-color: @fg; }
    window { width: 350px; background-color: @bg; border: 2px; border-color: @accent; border-radius: 12px; }
    mainbox { padding: 15px; }
    inputbar { enabled: false; }
    listview { lines: 4; spacing: 8px; fixed-height: true; }
    element { padding: 10px; border-radius: 8px; cursor: pointer; }
    element selected { background-color: #313244; text-color: @accent; }
')

# Apply the chosen TuneD profile
case "$SELECTION" in
    *"Throughput Performance"*)
        tuned-adm profile throughput-performance
        notify-send -a "Noctra OS" "TuneD Profile" "Switched to Throughput Performance ⚡"
        ;;
    *"Balanced"*)
        tuned-adm profile balanced
        notify-send -a "Noctra OS" "TuneD Profile" "Switched to Balanced Mode ⚖️"
        ;;
    *"Power Saver"*)
        tuned-adm profile powersave
        notify-send -a "Noctra OS" "TuneD Profile" "Switched to Power Saver Mode 🔋"
        ;;
    *"Laptop AC Powersave"*)
        tuned-adm profile laptop-ac-powersave
        notify-send -a "Noctra OS" "TuneD Profile" "Switched to Laptop AC Battery Mode 💻"
        ;;
esac