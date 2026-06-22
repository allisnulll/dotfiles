# Source
export PATH="$HOME/src/nvimpager:$PATH"
export XDG_SCREENSHOTS_DIR="$HOME/Pictures/screenshots"

# Environment Variables
export EDITOR="nvim"
export PAGER="nvimpager"
export MANPAGER="nvimpager"

# Colored Manpages
export GROFF_NO_SGR=1
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;33;44m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4;1;32m'
export LESS_TERMCAP_mr=$'\e[7m'
export LESS_TERMCAP_mh=$'\e[2m'
export LESS_TERMCAP_ZN=$'\e[74m'
export LESS_TERMCAP_ZV=$'\e[75m'
export LESS_TERMCAP_ZO=$'\e[73m'
export LESS_TERMCAP_ZW=$'\e[75m'

# Python
export CONDA_PLUGINS_AUTO_ACCEPT_TOS=true
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# Conda
if [[ "$(pyenv version-name 2>/dev/null)" == "miniconda3-latest" ]]; then
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$(\"$HOME/.pyenv/versions/miniconda3-latest/bin/conda\" 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$HOME/.pyenv/versions/miniconda3-latest/etc/profile.d/conda.sh" ]; then
            . "$HOME/.pyenv/versions/miniconda3-latest/etc/profile.d/conda.sh"
        else
            export PATH="$HOME/.pyenv/versions/miniconda3-latest/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
else
    unset CONDA_DEFAULT_ENV CONDA_PREFIX CONDA_EXE CONDA_SHLVL CONDA_PROMPT_MODIFIER
fi

# Flutter
export PATH="$HOME/fvm/default/bin:$PATH"
[[ -f $HOME/.config/.dart-cli-completion/zsh-config.zsh ]] && . $HOME/.config/.dart-cli-completion/zsh-config.zsh || true

# Android
export PATH="$HOME/Android/Sdk/emulator/:$PATH"
export PATH="$HOME/Android/Sdk/platform-tools:$PATH"
export ANDROID_AVD_HOME="$HOME/.config/.android/avd"

export CHROME_EXECUTABLE="/usr/bin/google-chrome-stable"
# export ADB_TRACE="all"

# Go
export GOBIN="$HOME/go/bin"
export PATH="$GOBIN:$PATH"

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
