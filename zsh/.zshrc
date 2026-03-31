# ┌─────────────────────────────────────────────────────────────┐
# │                    ~/.zshrc - Noctra OS                     │
# └─────────────────────────────────────────────────────────────┘

# 1. Environment & Paths
export PATH="$HOME/bin:/usr/local/bin:$HOME/.cargo/bin:$PATH"
export EDITOR="nvim"

# 2. History Settings
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=50000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY

# 3. Completion System
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

# 4. The "Noctra" Identity
# Moved up so it executes before plugins to keep prompt rendering instantaneous
if [[ -o interactive ]]; then
    fastfetch --config $HOME/.config/fastfetch/config.jsonc
fi

# 5. Prompt - Starship
eval "$(starship init zsh)"

# 6. Aliases
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias wall='matugen image'
alias refresh='pkill -USR2 waybar'
alias ls='eza --icons --group-directories-first'
alias ll='eza -lah --icons'
alias v='nvim'

# 7. Lazy-Loaded NVM (Performance Tweak)
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

# 8. Plugins (ORDER IS CRITICAL)
# Source Autosuggestions FIRST
if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Source Syntax Highlighting LAST
if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Define styles AFTER sourcing, using Kitty's dynamic Matugen ANSI palette
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=4,bold'       # Uses Matugen Primary Container
ZSH_HIGHLIGHT_STYLES[alias]='fg=5,bold'         # Uses Matugen Secondary
ZSH_HIGHLIGHT_STYLES[path]='fg=7,underline'     # Uses Matugen On-Surface
ZSH_HIGHLIGHT_STYLES[error]='fg=1,bold'         # Uses Matugen Error
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"          # Uses Matugen Surface-Variant
