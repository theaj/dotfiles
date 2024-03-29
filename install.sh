#!/bin/bash

# get os
platform=""
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    platform="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    platform="macos"
fi

# install zsh and other stuff
setup_terminal() {
    echo "=> Installing zsh"
    if [[ $platform == "linux" ]]; then
        sudo apt install zsh -y
    elif [[ $platform == "macos" ]]; then
        brew install zsh
    fi

    if [[ ! -d $HOME/.oh-my-zsh ]]; then
        echo "=> Installing oh-my-zsh"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

        echo "=> Installing zsh-autosuggestions"
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

        echo "=> Installing zsh-syntax-highlighting"
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

        echo "=> Installing powerlevel10k"
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

        echo "=> Importing zshrc"
        rm -rf $HOME/.zshrc
        ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc

        echo "=> Importing powerlevel10k"
        rm -rf $HOME/.p10k.zsh
        ln -s $HOME/dotfiles/.p10k.zsh $HOME/.p10k.zsh
    fi
}

setup_terminal