#!/usr/bin/env zsh

cd ~
clear
paru -S --needed fastfetch eza zoxide btop htop powertop tree tmux go sesh-bin fzf ripgrep fd jq wget cmake clang nodejs npm lua51 python python-pynvim python-pip xdg-user-dirs noto-fonts noto-fonts-emoji noto-fonts-cjk noto-fonts-extra

xdg-user-dirs-update
cargo install tree-sitter-cli

sudo usermod -c "AllIsNull" allisnull

nvim_bck_created=0
nvimpager_bck_created=0

# Neovim
function neovim_install() {
    cd ~/src/neovim
    git clone --depth=1 https://github.com/neovim/neovim.git .
    git apply ~/.dotfiles/patches/nvim-ufo.patch

    sudo make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
}

if [[ -d ~/src/neovim ]]; then
    echo "\e[38;5;52mWould you like to re-install NeoVim? (y/n)\e[0m "
    vared -c answer
    if [[ "${answer:l}" == "y" ]]; then
        if [[ -d ~/src/neovim.bck ]]; then
            unset answer
            echo "\e[38;5;52mWould you like to overwrite neovim.bck? (y/n)\e[0m "
            vared -c answer
            if [[ "${answer:l}" == "y" ]]; then
                rm ~/src/neovim.bck -rf
                mv ~/src/neovim ~/src/neovim.bck
                nvim_bck_created = 1
            else
                echo "\e[38;5;52mWill not overwrite neovim.bck.\e[0m"
            fi
        else
            mv ~/src/neovim ~/src/neovim.bck
            nvim_bck_created = 1
        fi
        sudo rm ~/src/neovim -rf
        mkdir ~/src/neovim
        neovim_install
    fi
else
    mkdir ~/src/neovim
    neovim_install
fi

# NvimPager
function nvimpager_install() {
    cd ~/src/nvimpager
    git clone --depth=1 https://github.com/lucc/nvimpager.git .
    git apply ~/.dotfiles/patches/nvimpager.patch

    make PREFIX=$HOME/.local install
}

cd ~
if [[ -d ~/src/nvimpager ]]; then
    unset answer
    echo "\e[38;5;52mWould you like to re-install NvimPager? (y/n)\e[0m "
    vared -c answer
    if [[ "${answer:l}" == "y" ]]; then
        if [[ -d ~/src/nvimpager.bck ]]; then
            unset answer
            echo "\e[38;5;52mWould you like to overwrite nvimpager.bck? (y/n):\e[0m "
            vared -c answer
            if [[ "${answer:l}" == "y" ]]; then
                rm ~/src/nvimpager.bck -rf
                mv ~/src/nvimpager ~/src/nvimpager.bck
                vimpager_bck_created = 1
            else
                echo "\e[38;5;52mWill not overwrite nvimpager.bck.\e[0m"
            fi
        else
            mv ~/src/nvimpager ~/src/nvimpager.bck
        fi
        rm ~/src/nvimpager -rf
        mkdir ~/src/nvimpager
        nvimpager_install
    fi
else
    mkdir ~/src/nvimpager
    nvimpager_install
fi

# Tmux Plugins
[[ -d ~/.tmux/plugins/tpm ]] || mkdir -p ~/.tmux/plugins/tpm
git clone --depth=1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Zsh Plugins
[[ -d ~/.zsh/plugins/zsh-autosuggestions ]] || mkdir -p ~/.zsh/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions
[[ -d ~/.zsh/plugins/zsh-syntax-highlighting ]] || mkdir -p ~/.zsh/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/plugins/zsh-syntax-highlighting
[[ -d ~/.zsh/plugins/zsh-completions ]] || mkdir -p ~/.zsh/plugins/zsh-completions
git clone --depth=1 https://github.com/zsh-users/zsh-completions.git ~/.zsh/plugins/zsh-completions
[[ -d ~/.zsh/plugins/zsh-vi-mode ]] || mkdir -p ~/.zsh/plugins/zsh-vi-mode
git clone --depth=1 https://github.com/jeffreytse/zsh-vi-mode.git ~/.zsh/plugins/zsh-vi-mode
[[ -d ~/.zsh/plugins/zsh-you-should-use ]] || mkdir -p ~/.zsh/plugins/zsh-you-should-use
git clone --depth=1 https://github.com/MichaelAquilina/zsh-you-should-use ~/.zsh/plugins/zsh-you-should-use
[[ -d ~/.zsh/plugins/powerlevel10k ]] || mkdir -p ~/.zsh/plugins/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/plugins/powerlevel10k

# Git Submodules
git clone https://github.com/allisnulll/keyboard ~/.dotfiles/kanata
git clone https://github.com/allisnulll/zsh-undo-dir ~/.dotfiles/.zsh/plugins/zsh-undo-dir
git clone --depth=1 https://github.com/Kiaryy/Milk-Outside-a-Bag-GTK-Theme ~/.dotfiles/.themes
git clone --depth=1 https://github.com/Kiaryy/Milk-Outside-a-Bag-Icon-Set ~/.dotfiles/.icons

[[ nvim_bck_created == 1 ]] && echo "\e[38;5;52mCreated backup of old neovim: ~/src/neovim.bck\e[0m"
[[ nvimpager_bck_created == 1 ]] && echo "\e[38;5;52mCreated backup of old nvimpager: ~/src/nvimpager.bck\e[0m"
