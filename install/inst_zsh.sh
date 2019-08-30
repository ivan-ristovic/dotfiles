#!/bin/bash

source "utils.sh"

inst $@ zsh
inst $@ python-pip
inst $@ git
pip install powerline-status > /dev/null
inst $@ fonts-powerline
inst $@ zsh-syntax-highlighting

# Install omz
wget -q -O install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
sh install.sh --unattended > /dev/null
rm install.sh
rm ~/.zshrc

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

if ask "Change the theme?"; then
    TMP_CURDIR=`pwd`
    cd ~
    if git clone "https://github.com/ivan-ristovic/zsh-theme.git" > /dev/null; then
        cd zsh_theme
        source "setup.sh" > /dev/null
    else
        err "Failed to clone the theme from GitHub"
    fi
    cd $TMP_CURDIR
    suc "Done"
fi

if ask "Change the default shell to zsh?"; then
    chsh -s "$(which zsh)"
    suc "Done"
fi
