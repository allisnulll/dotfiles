# Source
export PATH="$HOME/src/nvimpager:$PATH"

# Environment Variables
export EDITOR="nvim"
export PAGER="nvimpager"
export MANPAGER="nvimpager"

# Python
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# Flutter
export PATH="/home/allisnull/fvm/default/bin:$PATH"
[[ -f /home/allisnull/.config/.dart-cli-completion/zsh-config.zsh ]] && . /home/allisnull/.config/.dart-cli-completion/zsh-config.zsh || true

export CHROME_EXECUTABLE="/usr/bin/google-chrome-stable"
# export ADB_TRACE="all"

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
export FZF_DEFAULT_OPTS="--scroll-off=4 --bind ctrl-d:page-down,ctrl-u:page-up,page-down:preview-page-down,page-up:preview-page-up,ctrl-v:toggle-preview --preview 'head -500 | nvimpager -c {}'"
export FZF_TMUX_OPTS="-p90%,70%"

export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_ALT_C_OPTS="--preview 'eza --tree --icons=always --color=always --git-ignore {} | head -500'"

# RipGrep
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# Puppeteer
export PUPPETEER_EXECUTABLE_PATH=$(which chromium)

# Doom Emacs
export PATH="$HOME/.emacs.doom/bin:$PATH"
