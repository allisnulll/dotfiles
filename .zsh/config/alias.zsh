# Aliases
alias c="clear"
alias h="history"
alias rm="rm -i"
alias rmd="rm -id"
alias mv="mv -i"
alias cp="cp -i"
alias ln="ln -i"
alias df="df -h"
alias du="du -sh"
alias mkdir="mkdir -p"
alias diff="diff --color=auto"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias so="source ~/.zsh/config/alias.zsh && source ~/.zsh/config/git.zsh && source ~/.zsh/config/function.zsh"
alias soa="source ~/.zshrc && source ~/.zshenv && source ~/.zprofile"

# NeoVim
alias v="nvim"

# NeoFetch
alias neo="c && fastfetch"

# Tmux
alias tx="sesh connect 🏠 Main; exec zsh"
alias txd="tmux detach"
alias txks="tmux kill-server"

# Eza
alias ls="eza --icons=always"
alias lsa="eza -a --icons=always"
alias lsl="eza -l --icons=always"
alias lsal="eza -al --icons=always"

# Zoxide
eval "$(zoxide init --cmd cd zsh)"

# Hyprctl
alias hr="hyprctl reload"

# Unzip
alias unzipa="for f in *.zip; do unzip '$f' -d '${f%.zip}'; done"

# Devices
alias blx="bluetoothctl connect 4F:63:57:C9:FA:58"
alias pc-sam="wol AC:82:47:C6:DF:13; tvd"

# TeamViewer
alias tv="sudo teamviewer --daemon start"
alias tvk="sudo pkill -f 'teamviewerd -d'"

# Flutter
alias flr="flutter run $@ --web-browser-flag='--ozone-platform-hint=wayland'"
alias flrc="flutter run -d chrome $@ --web-browser-flag='--ozone-platform-hint=wayland'"
alias flrl="flutter run -d linux $@ --web-browser-flag='--ozone-platform-hint=wayland'"
alias flrw="flutter run -d 192.168.1.215:58526 $@ --web-browser-flag='--ozone-platform-hint=wayland'"
alias fle="firebase emulators:start --import emulators_data --export-on-exit"
alias adbr="adb shell settings put system user_rotation 0"

# Kanata
alias kn="kanata -c ~/kanata/kanata.kdb --log-layer-changes"
alias knd="kanata -dc ~/kanata/kanata.kdb --log-layer-changes"
alias kns="systemctl --user stop kanata"
alias knl="systemctl --user status kanata"
alias knr="systemctl --user daemon-reload && systemctl --user restart kanata"
