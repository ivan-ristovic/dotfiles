#!/bin/bash

ROOT_DIR=`pwd`

# Load utils
GIT_DIR=`grep ivan-ristovic/dotfiles .git/config`
if [ -z "$GIT_DIR" ]; then
	echo "Not in dotfiles directory. Exiting ..."
    exit 1
fi
if [ ! -d "install" ]; then
    echo "`install` directory is not present. Exiting ..."
    exit 1
fi

source "install/utils.sh"

# Check if sudo
if [ "$EUID" -ne 0 ]; then 
    fat "usage: sudo $0 [install/list/path]"
fi

# Get install list path
INSTALL_LIST="apt_install.list"
if [ $# -ge 1 ]; then
    if [ -f $1 ]; then
        INSTALL_LIST=$1
    else
        fat "can't find file: $1"
    fi
fi

# Identify package manager
PM=`pm_cmd`
msg "Package manager installation command identified as: $PM"

# Install packages
suc "Checks completed successfully, starting installations..."
for entry in `rm_comments "$INSTALL_LIST"`; do
    cd "install"
    SETUP_SCRIPT="inst_$entry.sh"
    if [ -f "$SETUP_SCRIPT" ]; then
        msg "Setting up via script : $entry"
        source "$SETUP_SCRIPT" $PM
    else
        msg "Installing package    : $entry"
        inst $PM $entry
    fi
    cd $ROOT_DIR
done
suc "Installations finished"

# Link dotfiles
msg "Linking dotfiles..."
if [ -d "dotfiles" ]; then
    cd "dotfiles"
    INIT_IGNORES=`cat ignore.list`
    for item in *; do

        IGNORED_FILE=""
        for ignored in $INIT_IGNORES; do
            if [[ "$ignored" = "$item" ]]; then
                IGNORED_FILE="$item"
            fi
        done

        if [ -n "$IGNORED_FILE" ]; then
            echo "Ignored: $item"
            continue;
        fi

        if [ -e "$HOME/.$item" ]; then
            echo "Skipped: .$item (already exists)"
            continue;
        fi

        echo "Linking: $item  to  ~/.$item"
        ln -s "$PWD/$item" "$HOME/.$item"

    done

    suc "Dotfiles linked."
else
    err "`dotfiles` directory is not present."
fi


suc "Done! Have a nice day."
