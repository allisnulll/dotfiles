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
alias soa="source ~/.zsh/config/plugins.zsh && source ~/.zsh/config/p10k.zsh && source ~/.zsh/config/alias.zsh && source ~/.zsh/config/git.zsh && source ~/.zsh/config/function.zsh && source ~/.zsh/config/history.zsh && source ~/.zshenv && source ~/.zprofile"

alias glob="setopt | rg extendedglob > /dev/null && unsetopt extended_glob || setopt extended_glob"
alias nocolor="sed -r 's/\x1B\[([0-9]{1,3}(;[0-9]{1,2};?)?)?[mGK]//g'"
alias fonts="fc-list --brief | rg 'fullname: \"' | rg -v 'Noto' | sed -r 's/\s+(Bold|Italic|Light|Medium|Thin|ExtraBold|Condensed|Regular|Oblique).*//' | sed 's/fullname: //' | sed 's/\"(s)//' | sed 's/\"//' | sed 's/\t//' | sort | uniq | nocolor"
alias ntest="sudo pkill dunst;c && notify-send 'TITLE' 'low' -u low && notify-send 'TITLE' 'normal' && notify-send 'TITLE' 'critical' -u critical"
alias copy="wl-copy"
alias dae="systemctl --user daemon-reload"

# Paru
alias p="paru"

# NeoFetch
alias neo="cd && c && fastfetch"

# NeoVim
alias v="nvim"

# Tmux
alias tx="sesh connect 🏠 Home; exec zsh"
alias txd="tmux detach"
alias txks="tmux kill-server"

# Fzf
alias cdf="cd \$(fd --type d | fzf --preview 'eza -a --icons=always --color=always {}' --bind ctrl-d:preview-page-down,ctrl-u:preview-page-up)"

# Eza
alias ls="eza --icons=always"
alias lsa="eza -a --icons=always"
alias lsA="eza -A"
alias lsl="eza -l --icons=always"
alias lsal="eza -al --icons=always"
alias lsAl="eza -Al"
alias lst="eza --icons=always --tree"
alias lsat="eza --icons=always --tree -a"
alias lsAt="ezA --tree -A"

alias lsi="eza --icons=always --git-ignore"
alias lsai="eza -a --icons=always --git-ignore"
alias lsAi="eza -A --git-ignore"
alias lsli="eza -l --icons=always --git-ignore"
alias lsali="eza -al --icons=always --git-ignore"
alias lsAli="eza -Al --git-ignore"
alias lsti="eza --icons=always --tree --git-ignore"
alias lsati="eza --icons=always --tree -a --git-ignore"
alias lsAti="ezA --tree -A --git-ignore"

# Zoxide
eval "$(zoxide init --cmd cd zsh)"

# Hyprctl
alias hr="hyprctl reload"

# Unzip
alias unzipa="for f in *.zip; do unzip '$f' -d '${f%.zip}'; done"

# Devices
alias bl="bluetoothctl"
alias xbox="bluetoothctl connect 98:7A:14:19:73:89"
alias blx="bluetoothctl connect 4F:63:57:C9:FA:58"
alias pc-sam="wol AC:82:47:C6:DF:13; tvd"
alias nix="ssh allisnull@192.168.1.215 && tmux rename-session ' NixOS'"

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
alias kn="kanata -c ~/kanata/kanata.kbd --log-layer-changes"
alias knd="kanata -dc ~/kanata/kanata.kbd --log-layer-changes"
alias kns="systemctl --user stop kanata"
alias knl="systemctl --user status kanata"
alias knr="systemctl --user daemon-reload && systemctl --user restart kanata"

# GhostScript
alias rd="\\gs"

# XDG
alias open="xdg-open"

# GtkLock
alias lock="~/.config/gtklock/lock.sh"

# Obsidian
alias ob="~/.dotfiles/scripts/obsidian_commit.sh"
alias vault="v ~/Vault/1741211101-main-hub.md '+ObsidianQuickSwitch'"

# Screensavers
alias pipes="tmux set status off; pipes-rs; tmux set status on"
alias pipes1="tmux set status off; pipes-rs -p 1000 -t 0 -r 1 --reset-threshold 0; tmux set status on"
alias pipes2="tmux set status off; pipes-rs -p 100 -k curved -c rgb -d 10 -r 0.9 -t 0.99; tmux set status on"

alias matrix="tmux set status off; cmatrix -su 3 -C red; tmux set status on"
alias bonsai="tmux set status off; cbonsai -iS --live; tmux set status on"

# Docker
alias dk="sudo systemctl start docker"
