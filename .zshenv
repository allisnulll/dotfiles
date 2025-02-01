# Environment Variables
export EDITOR="nvim"

# Flutter
export PATH="$HOME/flutter/bin:$PATH"
export PATH="$HOME/.pub-cache/bin:$PATH"
export CHROME_EXECUTABLE="/usr/bin/google-chrome-stable"

export ADB_TRACE="all"

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
