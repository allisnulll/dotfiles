#!/bin/zsh

source ~/.zsh/config/function.zsh

tmux new-window \;\
     send-keys "c && git status" Enter \;\
     new-window -n "run"

flw

tmux select-pane -t 0 \;\
     select-window -t 1 \;\
     send-keys "cd lib && nvim . -c 'autocmd VimEnter * Telescope find_files'; clear" Enter
