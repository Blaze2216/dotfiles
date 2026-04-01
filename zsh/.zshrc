# ┌─────────────────────────────────────────────────────────────┐
# │                    ~/.zshrc - Noctra OS                     │
# └─────────────────────────────────────────────────────────────┘

# 1. Environment & Paths
export PATH="$HOME/bin:/usr/local/bin:$HOME/.cargo/bin:$PATH"
export EDITOR="nvim"

# 2. Options & History
setopt EXTENDED_GLOB      # CRITICAL: Required for the 24h completion cache check to work
setopt NO_BEEP            # Disables annoying terminal error beeps
setopt AUTO_CD            # Type a directory name (e.g., Downloads) to cd into it automatically
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=50000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY

# 3. Aliases
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias wall='matugen image'
alias refresh='pkill -USR2 waybar'
alias ls='eza --icons --group-directories-first'
alias ll='eza -lah --icons'
alias v='nvim'
# The Noctra OS Image Fetcher
alias fetch='fastfetch --logo-type kitty --logo $(find ~/.config/fastfetch/images -type f | shuf -n 1)'

# 4. Completion System
autoload -Uz compinit
# Checks if the compdump file is older than 24 hours to save startup time
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

# 5. Lazy-Loaded NVM (Performance Tweak)
export NVM_DIR="$HOME/.nvm"
zsh_lazy_load_nvm() {
    unset -f nvm node npm npx yarn
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
}
nvm()  { zsh_lazy_load_nvm; nvm "$@"; }
node() { zsh_lazy_load_nvm; node "$@"; }
npm()  { zsh_lazy_load_nvm; npm "$@"; }
npx()  { zsh_lazy_load_nvm; npx "$@"; }
yarn() { zsh_lazy_load_nvm; yarn "$@"; }

# 6. Plugins (ORDER IS CRITICAL)
if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Define styles AFTER sourcing, using Kitty's dynamic Matugen ANSI palette
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=4,bold'       # Matugen Primary Container
ZSH_HIGHLIGHT_STYLES[alias]='fg=5,bold'         # Matugen Secondary
ZSH_HIGHLIGHT_STYLES[path]='fg=7,underline'     # Matugen On-Surface
ZSH_HIGHLIGHT_STYLES[error]='fg=1,bold'         # Matugen Error
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"          # Matugen Surface-Variant

# 7. Prompt - Starship
eval "$(starship init zsh)"

# 8. The "Noctra" Identity (Startup Execution)
# Moved to the very end so it can use the 'fetch' alias we defined in Step 3!
if [[ -o interactive ]]; then
    fetch
fi