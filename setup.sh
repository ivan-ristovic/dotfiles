#!/bin/bash

ROOT_DIR=$(pwd)

# Load utils
GIT_DIR=$(grep ivan-ristovic/dotfiles .git/config)
if [ -z "$GIT_DIR" ]; then
    echo "Not in dotfiles directory. Exiting ..."
    exit 1
fi
if [ ! -d "install" ]; then
    echo "install/ directory is not present. Exiting ..."
    exit 1
fi

source "install/utils.sh"

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    msg "usage: $0 [username] [install_list]"
    exit 0
fi

# Set home dir
export SETUP_HOME_DIR="/home/ivan"
export SETUP_USER="ivan"
if [ $# -ge 1 ]; then
    SETUP_USER="$1"
    SETUP_HOME_DIR="/home/$1"
fi
msg "home dir: $SETUP_HOME_DIR"

# Get install list path
INSTALL_LIST="lst_local_arch"
if [ $# -ge 2 ]; then
    if [ -f "$2" ]; then
        INSTALL_LIST="$2"
    else
        fat "can't find file: $2"
    fi
fi
msg "install list: $INSTALL_LIST"

# Identify package manager
PM=$(pm_cmd)
msg "Package manager installation command identified as: $PM"

# Install packages
suc "Checks completed successfully, starting installations ..."

function process_list
{
    for entry in $(rm_comments "$1"); do
        cd "install"
        SETUP_SCRIPT="inst_$entry.sh"
        AUR_PREFIX="aur:"
        if [[ "$entry" == "+"* ]]; then
            cd $ROOT_DIR
            to_include=${entry#"+"}
            msg "Importing setup script: $to_include"
            process_list "$to_include"
        elif [ -f "$SETUP_SCRIPT" ]; then
            msg "Setting up via script : $entry"
            source "$SETUP_SCRIPT" "$PM"
        elif [[ "$entry" == "$AUR_PREFIX"* ]]; then
            pkg=${entry#"$AUR_PREFIX"}
            msg "Installing from AUR: $pkg"
            inst_aur "$pkg"
        else
            msg "Installing package    : $entry"
            inst "$PM" "$entry"
        fi
        cd "$ROOT_DIR"
        suc "Finished processing $entry."
        sleep 2
    done
}

process_list "$INSTALL_LIST"
suc "Installations finished."

# Link dotfiles
msg "Setting up dotfiles in: $SETUP_HOME_DIR ..."
if [ -d "dotfiles" ]; then
    cd "dotfiles"
    INIT_IGNORES=$(cat ignore.list)
    for item in *; do

        IGNORED_FILE=""
        for ignored in $INIT_IGNORES; do
            if [[ "$ignored" = "$item" ]]; then
                IGNORED_FILE="$item"
            fi
        done

        if [ -n "$IGNORED_FILE" ]; then
            echo "Ignoring $item ..."
            continue;
        fi

        if [ -e "$SETUP_HOME_DIR/.$item" ]; then
            echo "Skipping: $SETUP_HOME_DIR/.$item (already exists) ..."
            continue;
        fi

        echo "Linking: $item -> $SETUP_HOME_DIR/.$item ..."
        ln -s "$PWD/$item" "$SETUP_HOME_DIR/.$item"

    done

    suc "Dotfiles linked."

    cd "config"
    for item in *; do
        echo "Linking: $item -> $SETUP_HOME_DIR/.config/$item ..."
        ln -s "$PWD/$item" "$SETUP_HOME_DIR/.config/$item"
    done

    suc "Conf files linked."
else
    err "dotfiles/ directory is not present."
fi


suc "Done! Have a nice day."
