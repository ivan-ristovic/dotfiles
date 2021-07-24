#!/bin/bash

source "utils.sh"

inst $@ zsh
inst $@ python3-pip
inst $@ git

msg "Installing powerline ..."
pip3 install powerline-status
inst $@ fonts-powerline

msg "Installing oh-my-zsh ..."
sudo -u $USER wget -q -O install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
ZSH="$SETUP_HOME_DIR"/.zsh sh install.sh --unattended
sh install.sh --unattended
rm install.sh
rm "$SETUP_HOME_DIR"/.zshrc

msg "Downloading syntax highlighting plugin ..."
sudo -u $USER git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$SETUP_HOME_DIR"/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

msg "Downloading powerlevel10k ..."
sudo -u $USER git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$SETUP_HOME_DIR"/.oh-my-zsh/custom/themes/powerlevel10k

if ask "Change the default shell to zsh?"; then
    sudo chsh -s "$(which zsh)"
    suc "Done"
fi
