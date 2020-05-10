#/bin/bash

source utils.sh

inst $@ git
inst $@ curl

inst $@ neovim

git clone https://github.com/VundleVim/Vundle.vim.git "$SETUP_HOME_DIR"/.vim/bundle/Vundle.vim > /dev/null

sudo vim +PluginInstall +qall &


