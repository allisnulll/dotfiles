git clone --depth=1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/jeffreytse/zsh-vi-mode.git ~/.zsh/plugins/zsh-vi-mode
git clone --depth=1 https://github.com/MichaelAquilina/zsh-you-should-use ~/.zsh/plugins/zsh-you-should-use
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/plugins/powerlevel10k

git -C ~/.local/share/nvim/lazy/ltex-utils.nvim apply ltex-utils.patch

git -C ~/src/neovim apply nvim-ufo.patch
