#!/bin/bash

source "utils.sh"

inst $@ zsh
inst $@ python-pip
pip install powerline-status > /dev/null
inst $@ fonts-powerline
inst $@ zsh-syntax-highlighting
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" --unattended
rm ~/.zshrc

if ask "Change the theme?"; then
    TMP_CURDIR=`pwd`
    cd ~
    inst $@ git
    if git clone "https://github.com/ivan-ristovic/zsh_theme.git" > /dev/null; then
        source ./zsh_theme/setup.sh > /dev/null
    else
        err "Failed to clone the theme from GitHub"
    cd $TMP_CURDIR
fi

if ask "Change the default shell to zsh?"; then
    chsh -s "$(which zsh)"
    suc "Done"
fi