#/bin/bash

source utils.sh

inst $@ git
inst $@ curl

inst $@ neovim

msg "Downloading Vundle ..."
sh -c 'curl -fLo "${XDG_DATA_HOME:-$SETUP_HOME_DIR/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

ln -s $SETUP_HOME_DIR/.vimrc $SETUP_HOME_DIR/.config/nvim/init.vim

msg "Installing plugins ..."
nvim +PlugInstall +qall

inst $@ python-pip
pip install pynvim

