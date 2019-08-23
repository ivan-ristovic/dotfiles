#/bin/bash

source utils.sh

inst $@ git
inst $@ curl

inst $@ neovim

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim > /dev/null

vim +PluginInstall +qall &


