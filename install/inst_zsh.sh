#!/bin/bash

source "utils.sh"

inst $@ zsh
inst $@ python3-pip
inst $@ git

msg "Installing powerline ..."
pip3 install powerline-status
inst $@ fonts-powerline

msg "Installing oh-my-zsh ..."
wget -q -O install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
sh install.sh --unattended
rm install.sh
rm ~/.zshrc

msg "Downloading syntax highlighting plugin ..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$SETUP_HOME_DIR/.oh-my-zsh/custom"/plugins/zsh-syntax-highlighting

if ask "Change the theme?"; then
    TMP_CURDIR=$(pwd)
    cd "$SETUP_HOME_DIR"
    if git clone "https://github.com/ivan-ristovic/xris47.zsh-theme.git"; then
        cd xris47.zsh-theme
        source "setup.sh" > /dev/null
    else
        err "Failed to clone the theme from GitHub"
    fi
    cd "$TMP_CURDIR"
    suc "Done"
fi

if ask "Change the default shell to zsh?"; then
    sudo chsh -s "$(which zsh)"
    suc "Done"
fi
