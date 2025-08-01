#!/usr/bin/env zsh

clear
nvim_bck_created=1
nvimpager_bck_created=1

sudo usermod -c "AllIsNull" allisnull

cd ~/.dotfiles

# Neovim
if [[ -d ~/src/neovim ]]; then
    mv ~/src/neovim ~/src/neovim.bck
    nvim_bck_created=0
fi

git -C ~/src/neovim clone --depth=1 https://github.com/neovim/neovim.git .
stow .
git -C ~/src/neovim apply patches/nvim-ufo.patch

sudo make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

# NvimPager
if [[ -d ~/src/nvimpager ]]; then
    mv ~/src/nvimpager ~/src/nvimpager.bck
    nvimpager_bck_created=0
fi

git -C ~/src/nvimpager clone --depth=1 https://github.com/lucc/nvimpager.git .
stow .
git -C ~/src/nvimpager apply patches/nvimpager.patch

make PREFIX=$HOME/.local install

# Tmux Plugins
git -C ~/.tmux/plugins/tpm clone --depth=1 https://github.com/tmux-plugins/tpm .

# Zsh Plugins
git -C ~/.zsh/plugins/zsh-autosuggestions clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions .
git -C ~/.zsh/plugins/zsh-syntax-highlighting clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git .
git -C ~/.zsh/plugins/zsh-vi-mode clone --depth=1 https://github.com/jeffreytse/zsh-vi-mode.git .
git -C ~/.zsh/plugins/zsh-you-should-use clone --depth=1 https://github.com/MichaelAquilina/zsh-you-should-use .
git -C ~/.zsh/plugins/powerlevel10k clone --depth=1 https://github.com/romkatv/powerlevel10k.git .

# Git Submodules
git clone https://github.com/allisnulll/keyboard ~/.dotfiles/kanata
git clone https://github.com/allisnulll/zsh-undo-dir ~/.dotfiles/.zsh/plugins/zsh-undo-dir
git clone --depth=1 https://github.com/Kiaryy/Milk-Outside-a-Bag-Icon-Set ~/.dotfiles/.icons
git clone --depth=1 https://github.com/Kiaryy/Milk-Outside-a-Bag-GTK-Theme ~/.dotfiles/.themes

if [[ nvim_bck_created ]]; then
    echo "Created copy of old neovim: ~/src/neovim.bck"
fi
if [[ nvimpager_bck_created ]]; then
    echo "Created copy of old nvimpager: ~/src/nvimpager.bck"
fi
