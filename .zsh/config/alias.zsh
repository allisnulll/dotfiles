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

# Flutter
alias flr="flutter run -d chrome $@ --web-browser-flag='--ozone-platform-hint=wayland'"
alias flrl="flutter run -d linux $@ --web-browser-flag='--ozone-platform-hint=wayland'"
alias fle="firebase emulators:start --import emulators_data --export-on-exit"

# Eza
alias ls="eza --icons=always"
alias lsa="eza -a --icons=always"
alias lsl="eza -l --icons=always"
alias lsal="eza -al --icons=always"

# Zoxide
eval "$(zoxide init --cmd cd zsh)"

# Unzip
alias unzipa="for f in *.zip; do unzip '$f' -d '${f%.zip}'; done"

# Bluetooth Devices
alias blx="bluetoothctl connect 4F:63:57:C9:FA:58"

# TeamViewer
alias tvd="sudo teamviewer --daemon start"
alias tvk="sudo pkill -f 'teamviewerd -d'"
