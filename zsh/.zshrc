# ┌─────────────────────────────────────────────────────────────┐
# │                    ~/.zshrc - Noctra OS                     │
# │             The All-Rounder's Cockpit - Feb 2026            │
# └─────────────────────────────────────────────────────────────┘

# 1. Environment & Paths
export PATH="$HOME/bin:/usr/local/bin:$HOME/.cargo/bin:$PATH" # Added Cargo for your Rust dev
export EDITOR="nvim" # Because you're a 5-year Linux veteran

# 2. History Settings
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=50000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY

# 3. Completion System (Arch optimized)
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zcompcache

# 4. Plugins (Arch Paths)
# Note: On Arch, these are usually in /usr/share/zsh/plugins/
# --- Noctra Syntax Highlighting ---
# Define styles BEFORE sourcing
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=#33ccff,bold'       # Noctra Blue
ZSH_HIGHLIGHT_STYLES[alias]='fg=#bb9af7,bold'         # Noctra Purple
ZSH_HIGHLIGHT_STYLES[path]='fg=white,underline'
ZSH_HIGHLIGHT_STYLES[error]='fg=#f7768e,bold'         # Material Red

# Source from the Arch-specific directory
if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Source Autosuggestions
if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# 5. The "Noctra" Identity (Fastfetch)
if [[ -o interactive ]]; then
    # Runs your dynamic Matugen-themed Fastfetch on every new terminal
    fastfetch --config /home/blaze/.config/fastfetch/config.jsonc
fi

# 6. Prompt - Starship (Rust-powered)
eval "$(starship init zsh)"

# 7. Aliases (Noctra Efficiency)
# Package management
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'

# Branding & Theming
alias wall='matugen image' # Usage: wall /path/to/img.png
alias refresh='pkill -USR2 waybar'

# General
alias ls='exa --icons --group-directories-first'
alias ll='exa -lah --icons'
alias v='nvim'
alias rust='cd ~/noctra-os/core/rust_projects' # Quick jump to your Rust work
alias hostel='cat ~/Documents/hostel_accounting.txt' # Quick check for your ITM accounting

# 8. NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"