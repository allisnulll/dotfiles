#!/usr/bin/env zsh

source ~/.zsh/config/function.zsh

tmux new-window \;\
     send-keys "c && gs" Enter \;\
     new-window \;\
     send-keys "c && pnpm run build && pnpm run start" Enter \;\
     select-window -t 1 \;\
     send-keys "v app/page.tsx -c ':lua vim.g.opencode_opts.server.start()'" Enter \;\
