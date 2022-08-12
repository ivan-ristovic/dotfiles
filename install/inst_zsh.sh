#!/bin/bash

source "utils.sh"

inst $@ zsh
inst $@ python-pip
inst $@ git
inst $@ curl

msg "Installing powerline ..."
pip install powerline-status
inst $@ fonts-powerline

msg "Installing oh-my-zsh ..."

sudo -u $SETUP_USER sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
rm "$SETUP_HOME_DIR"/.zshrc

msg "Downloading syntax highlighting plugin ..."
sudo -u $SETUP_USER git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$SETUP_HOME_DIR"/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

msg "Downloading powerlevel10k ..."
sudo -u $SETUP_USER git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$SETUP_HOME_DIR"/.oh-my-zsh/custom/themes/powerlevel10k

msg "Downloading zplug ..."
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

rm $SETUP_HOME_DIR/.bashrc
sudo -u $SETUP_USER chsh -s "$(which zsh)"

