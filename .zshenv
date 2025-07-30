# Environment Variables
export EDITOR="nvim"

# Flutter
export PATH="$HOME/flutter/bin:$PATH"
export PATH="$HOME/.pub-cache/bin:$PATH"
# export ADB_TRACE="all"
export CHROME_EXECUTABLE="/usr/bin/google-chrome-stable"

# Go
export GOBIN="$HOME/go/bin"
export PATH="$GOBIN:$PATH"

# Rust Cargo
source $HOME/.cargo/env

# Qt
QT_QPA_PLATFORM="wayland"

# Electron
ELECTRON_OZONE_PLATFORM_HINT="wayland"

# Zsh-Vim-Mode
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT

MODE_CURSOR_VIINS="#00ff00 bar"
MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS #ff0000 blinking bar"
MODE_CURSOR_VICMD="green block"
MODE_CURSOR_SEARCH="#ff00ff steady underline"
MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #00ffff"

# Fzf
eval "$(fzf --zsh)"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS="--bind ctrl-d:preview-page-down,ctrl-u:preview-page-up,ctrl-v:toggle-preview"
export FZF_TMUX_OPTS="-p90%,70%"

export FZF_CTRL_C_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_ALT_C_OPTS="--preview 'eza --tree --icons=always --color=always --git-ignore {} | head -500'"

# RipGrep
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# Bat
export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

# Puppeteer
export PUPPETEER_EXECUTABLE_PATH=$(which chromium)

# Doom Emacs
export PATH="$HOME/.emacs.doom/bin:$PATH"
