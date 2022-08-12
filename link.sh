#!/bin/bash

ROOT_DIR=$(pwd)

# Check for dotfiles root
GIT_DIR=$(grep ivan-ristovic/dotfiles .git/config)
if [ -z "$GIT_DIR" ]; then
    echo "Not in dotfiles directory. Exiting ..."
    exit 1
fi
if [ ! -d "install" ]; then
    echo "install/ directory is not present. Exiting ..."
    exit 1
fi

# Load utils
source "install/utils.sh"

home_dir=$HOME
if [[ $# -ge 1 ]]; then
    home_dir=$1
fi

if [ ! -d "dotfiles" ]; then
    fat "dotfiles/ directory is not present. Exiting ..."
fi

# Ensure to make .config dir so that the directory
# is not symlinked (otherwise all programs would 
# dump their config into the dotfiles directory)
mkdir -p $home_dir/.config

# Move existing bashrc to avoid conflicts when running 
# for the first time
bashrc_backup_dir=/tmp/dotfiles
mkdir -p $bashrc_backup_dir
mv $home_dir/.bashrc $bashrc_backup_dir

pushd dotfiles
stow -v . -t $home_dir 
if [[ $? -eq 0 ]]; then
    suc "Dotfiles linked."
    rm -rf $bashrc_backup_dir
else
    err "Failed linking dotfiles!"
    mv $bashrc_backup_dir/.bashrc $home_dir
fi
popd

unset home_dir
unset bashrc_backup_dir

