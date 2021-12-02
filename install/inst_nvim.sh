#/bin/bash

source utils.sh

inst $@ git
inst $@ curl

inst $@ neovim

msg "Downloading Vundle ..."
git clone https://github.com/VundleVim/Vundle.vim.git "$SETUP_HOME_DIR"/.config/nvim/bundle/Vundle.vim
sudo chown $SETUP_USER:$SETUP_USER $SETUP_HOME_DIR/.config/nvim -R

ln -s $SETUP_HOME_DIR/.vimrc $SETUP_HOME_DIR/.config/nvim/init.vim

msg "Installing plugins ..."
vim +PluginInstall +qall

