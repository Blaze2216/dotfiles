# 🌌 Noctra OS | Hyprland Dotfiles

A high-performance, modular desktop configuration built on Arch Linux and Hyprland. Designed for a dark, minimalist aesthetic with a focus on system efficiency and keyboard-driven workflow.

![Desktop Preview](https://github.com/Blaze2216/dotfiles/blob/main/assets/2026-03-28_13-03-1774686420.png?raw=true) 

![Desktop Preview](https://github.com/Blaze2216/dotfiles/blob/main/assets/2026-03-28_13-03-1774686478.png?raw=true)

## 🛠️ Tech Stack & Specs

| Component | Choice | Description |
| :--- | :--- | :--- |
| **OS** | Arch Linux | Minimal base installation |
| **WM** | Hyprland (Wayland) | Dynamic tiling window manager |
| **Bar** | Waybar | Custom "notch" design with targeted blur removal |
| **Terminal** | Kitty | GPU-accelerated terminal emulator |
| **Wallpaper** | awww | Wayland wallpaper daemon for smooth transitions |
| **Hardware** | AMD Ryzen 5 | Optimized for integrated Radeon graphics |

## 🏗️ Architecture & Features

This configuration moves away from a monolithic setup into a highly maintainable, modular structure:

* **Modular Hyprland Config:** Core settings are kept clean by extracting system logic into separate files:
  * `monitors.conf`: Handles display outputs and scaling.
  * `keybindings.conf`: Centralized shortcut management.
* **Refined UI:** Waybar is styled as a clean top-notch rather than a floating pill, stripping out unnecessary background blur to maximize performance and visual clarity.
* **Modern Wayland Daemons:** Utilizes `awww` (formerly swww) for reliable layer-shell wallpaper rendering without caching bugs.

## 📂 Directory Structure

```text
~/.config/
├── hypr/
│   ├── hyprland.conf       # Main entry point
│   ├── monitors.conf       # Display configuration
│   └── keybindings.conf    # Shortcuts and dispatchers
├── waybar/
│   ├── config.jsonc        # Notch layout structure
│   └── style.css           # Styling and blur rules
├── kitty/
│   └── kitty.conf          # Terminal aesthetics
└── rofi/                   # Application launcher
```

## ⚡ Keybindings

| Action | Shortcut |
| :--- | :---|
| **Launch Terminal** | SUPER + Return |
| **Close Window** | SUPER + Q |
| **App Launcher** | SUPER + A |
| **Toggle Floating** | SUPER + V |
| **Reload Waybar** | SUPER + R | 
| **Open Browser** | SUPER + B |
| **Screenshot | PrtSc |
