#/bin/bash

source utils.sh

inst $@ git
inst $@ curl

inst $@ neovim

msg "Downloading Vundle ..."
sudo -u $USER git clone https://github.com/VundleVim/Vundle.vim.git "$SETUP_HOME_DIR"/.vim/bundle/Vundle.vim

msg "Installing plugins ..."
vim +PluginInstall +qall 


