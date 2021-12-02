#!/bin/bash

source "utils.sh"

inst $@ zsh
inst $@ python3-pip
inst $@ git
inst $@ curl

msg "Installing powerline ..."
pip3 install powerline-status
inst $@ fonts-powerline

msg "Installing oh-my-zsh ..."

sudo -u $SETUP_USER sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

#sudo -u $SETUP_USER wget -q -O install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
#ZSH="$SETUP_HOME_DIR"/.zsh sh install.sh --unattended
#rm install.sh
rm "$SETUP_HOME_DIR"/.zshrc

msg "Downloading syntax highlighting plugin ..."
sudo -u $SETUP_USER git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$SETUP_HOME_DIR"/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
inst $@ chroma

msg "Downloading powerlevel10k ..."
sudo -u $SETUP_USER git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$SETUP_HOME_DIR"/.oh-my-zsh/custom/themes/powerlevel10k

if ask "Change the default shell to zsh?"; then
    sudo -u $SETUP_USER chsh -s "$(which zsh)"
    suc "Done"
fi
