source ~/.zsh/config/plugins.zsh
source ~/.zsh/config/p10k.zsh
source ~/.zsh/config/alias.zsh
source ~/.zsh/config/git.zsh
source ~/.zsh/config/function.zsh
source ~/.zsh/config/history.zsh

if [[ -n "$TMUX_POPUP" ]]; then
    sneo
elif [[ $(tmux display-message -p "#S") == "🏠 Home" ]]; then
    neo
else
    c
fi
