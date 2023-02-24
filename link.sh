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

# Ensure .config dir exists so that it is not
# symlinked (otherwise all programs would dump
# their config into the dotfiles directory)
mkdir -p $home_dir/.config

# Force overwrites of specified files (save backup to /tmp)
backup_dir=/tmp/dotfiles
rm -rf $backup_dir
force_overwrite_list=$(read_list ".link.force")
for entry in $force_overwrite_list; do
    entry_path="$home_dir/$entry"
    if [[ -f $entry_path && ! -h $entry_path ]]; then
        mkdir -p $backup_dir
        msg "Forcing overwrite of: $entry_path ; backup at $backup_dir"
        mv $entry_path $backup_dir
    fi
done

pushd dotfiles
stow --no-folding -v . -t $home_dir 
if [[ $? -eq 0 ]]; then
    suc "Dotfiles linked."
else
    err "Failed linking dotfiles!"
fi
popd

unset home_dir
unset bashrc_backup_dir

