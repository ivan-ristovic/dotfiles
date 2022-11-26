#!/bin/bash

source "utils.sh"

if is_installed omz ; then
    print_already_installed zsh
    return
fi

inst $@ zsh
inst $@ python-pip
inst $@ git
inst $@ curl

msg "Installing powerline ..."
as_user pip3 install powerline-status

msg "Installing oh-my-zsh ..."
gcl https://github.com/ohmyzsh/ohmyzsh.git "$SETUP_HOME_DIR"/.oh-my-zsh/
# as_user sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
rm "$SETUP_HOME_DIR"/.zshrc

msg "Downloading syntax highlighting plugin ..."
gcl https://github.com/zsh-users/zsh-syntax-highlighting.git "$SETUP_HOME_DIR"/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

msg "Downloading powerlevel10k ..."
gcl --depth=1 https://github.com/romkatv/powerlevel10k.git "$SETUP_HOME_DIR"/.oh-my-zsh/custom/themes/powerlevel10k

msg "Downloading zplug ..."
gcl https://github.com/zplug/zplug.git $SETUP_HOME_DIR/.zplug

as_user chsh -s "$(which zsh)"

