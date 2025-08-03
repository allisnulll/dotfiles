#!/usr/bin/env zsh

clear
nvim_bck_created=1
nvimpager_bck_created=1

sudo usermod -c "AllIsNull" allisnull

cd ~/.dotfiles

# Neovim
if [[ -d ~/src/neovim ]]; then
    if [[ -d ~/src/neovim.bck ]]; then
        echo "\e[38;5;52mWould you like to overwrite neovim.bck? (y/n)\e[0m "
        vared -c answer
        case $answer in
            [Yy]) rm ~/src/neovim.bck -rf && mv ~/src/neovim ~/src/neovim.bck && nvim_bck_created=0 ;;
            *) echo "\e[38;5;52mWill not overwrite neovim.bck.\e[0m" ;;
        esac
    else
        mv ~/src/neovim ~/src/neovim.bck
    fi
    rm ~/src/neovim -rf
    mkdir ~/src/neovim
fi

git -C ~/src/neovim clone --depth=1 https://github.com/neovim/neovim.git .
stow .
git -C ~/src/neovim apply ~/.dotfiles/patches/nvim-ufo.patch

sudo make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

# NvimPager
if [[ -d ~/src/nvimpager ]]; then
    if [[ -d ~/src/nvimpager.bck ]]; then
        unset answer
        echo "\e[38;5;52mWould you like to overwrite nvimpager.bck? (y/n):\e[0m "
        vared -c answer
        case $answer in
            [Yy]) rm ~/src/nvimpager.bck -rf && mv ~/src/nvimpager ~/src/nvimpager.bck && vimpager_bck_created=0 ;;
            *) echo "\e[38;5;52mWill not overwrite nvimpager.bck.\e[0m" ;;
        esac
    else
        mv ~/src/nvimpager ~/src/nvimpager.bck
    fi
    rm ~/src/nvimpager -rf
    mkdir ~/src/nvimpager
fi

git -C ~/src/nvimpager clone --depth=1 https://github.com/lucc/nvimpager.git .
stow .
git -C ~/src/nvimpager apply ~/.dotfiles/patches/nvimpager.patch

make PREFIX=$HOME/.local install

# Tmux Plugins
git -C ~/.tmux/plugins/tpm clone --depth=1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Zsh Plugins
git -C ~/.zsh/plugins/zsh-autosuggestions clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions
git -C ~/.zsh/plugins/zsh-syntax-highlighting clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/plugins/zsh-syntax-highlighting
git -C ~/.zsh/plugins/zsh-vi-mode clone --depth=1 https://github.com/jeffreytse/zsh-vi-mode.git ~/.zsh/plugins/zsh-vi-mode
git -C ~/.zsh/plugins/zsh-you-should-use clone --depth=1 https://github.com/MichaelAquilina/zsh-you-should-use ~/.zsh/plugins/zsh-you-should-use
git -C ~/.zsh/plugins/powerlevel10k clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/plugins/powerlevel10k

# Git Submodules
git clone https://github.com/allisnulll/keyboard ~/.dotfiles/kanata
git clone https://github.com/allisnulll/zsh-undo-dir ~/.dotfiles/.zsh/plugins/zsh-undo-dir
git clone --depth=1 https://github.com/Kiaryy/Milk-Outside-a-Bag-Icon-Set ~/.dotfiles/.icons
git clone --depth=1 https://github.com/Kiaryy/Milk-Outside-a-Bag-GTK-Theme ~/.dotfiles/.themes

if [[ nvim_bck_created ]]; then
    echo "\e[38;5;52mCreated backup of old neovim: ~/src/neovim.bck\e[0m"
fi
if [[ nvimpager_bck_created ]]; then
    echo "\e[38;5;52mCreated backup of old nvimpager: ~/src/nvimpager.bck\e[0m"
fi
