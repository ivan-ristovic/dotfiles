#/bin/bash

source utils.sh

inst $@ git
inst $@ curl

inst $@ neovim

msg "Downloading vim-plug ..."
sudo -u $SETUP_USER sh -c 'curl -fLo "${XDG_DATA_HOME:-$SETUP_HOME_DIR/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

msg "Installing plugins ..."
nvim +PlugInstall +qall

inst $@ python-pip
pip install pynvim
