#!/bin/bash

source "utils.sh"

inst $@ zsh
inst $@ python-pip

msg "Installing powerline ..."
as_user pip3 install powerline-status

if [ ! -d "$SETUP_HOME_DIR"/.oh-my-zsh/ ]; then
    msg "Installing oh-my-zsh ..."
    gcl https://github.com/ohmyzsh/ohmyzsh.git "$SETUP_HOME_DIR"/.oh-my-zsh/
    # as_user sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

rm -f "$SETUP_HOME_DIR"/.zshrc

if [ ! -d "$SETUP_HOME_DIR"/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
    msg "Downloading syntax highlighting plugin ..."
    gcl https://github.com/zsh-users/zsh-syntax-highlighting.git "$SETUP_HOME_DIR"/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

if [ ! -d "$SETUP_HOME_DIR"/.oh-my-zsh/custom/themes/powerlevel10k ]; then
    msg "Downloading powerlevel10k ..."
    gcl --depth=1 https://github.com/romkatv/powerlevel10k.git "$SETUP_HOME_DIR"/.oh-my-zsh/custom/themes/powerlevel10k
fi

if [ ! -d "$SETUP_HOME_DIR"/.zplug ]; then
    msg "Downloading zplug ..."
    gcl https://github.com/zplug/zplug.git $SETUP_HOME_DIR/.zplug
fi

sudo usermod --shell "$(which zsh)" $SETUP_USER

