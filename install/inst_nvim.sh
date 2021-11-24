#/bin/bash

source utils.sh

inst $@ git
inst $@ curl

inst $@ neovim

msg "Downloading Vundle ..."
git clone https://github.com/VundleVim/Vundle.vim.git "$SETUP_HOME_DIR"/.vim/bundle/Vundle.vim
sudo chown $SETUP_USER:$SETUP_USER $SETUP_HOME_DIR/.vim/ -R

msg "Installing plugins ..."
vim +PluginInstall +qall
