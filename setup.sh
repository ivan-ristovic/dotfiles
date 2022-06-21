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

function usage ()
{
    msg "usage: $0 username install_list"
    echo
    echo "OPTIONS:"
    echo -e "\t--help -h: prints this manual"
    echo
    echo -e "\t--packages: install packages"
    echo -e "\t--dotfiles: link dotfiles"
    echo -e "\t--config: link config files"
    echo -e "\t--all: do all of the above (default)"
    exit 0
}

SETUP_OVERRIDE=false
SETUP_PACKAGES=false
SETUP_DOTFILES=false
SETUP_CONFIG=false

# Check arguments
while test $# -gt 0
do
    case "$1" in
        --help)
            usage
            ;;
        --all)
            SETUP_OVERRIDE=false
            ;;
        --packages)
            SETUP_OVERRIDE=true
            SETUP_PACKAGES=true
            ;;
        --dotfiles)
            SETUP_OVERRIDE=true
            SETUP_DOTFILES=true
            ;;
        --config)
            SETUP_OVERRIDE=true
            SETUP_CONFIG=true
            ;;
        -h) usage
            ;;
        --*)
            echo "unknown option: $1"
            usage
            ;;
        *)
            if [ -z $SETUP_USER ]; then
                export SETUP_USER=$1
                export SETUP_HOME_DIR="/home/${SETUP_USER}"
            elif [ -z $INSTALL_LIST ]; then
                if [ -f "$1" ]; then
                    INSTALL_LIST=$1
                else
                    fat "can't find install list: $1"
                fi
            fi
            ;;
    esac
    shift
done

if [[ -z $SETUP_HOME_DIR || -z $INSTALL_LIST ]]; then
    usage
fi

msg "home dir: $SETUP_HOME_DIR"
msg "install list: $INSTALL_LIST"

if ! $SETUP_OVERRIDE ; then 
    SETUP_PACKAGES=true
    SETUP_DOTFILES=true
    SETUP_CONFIG=true
fi

if $SETUP_PACKAGES ; then

    # Identify package manager
    PM=$(pm_cmd)
    msg "Package manager installation command identified as: $PM"

    # Install packages
    suc "Checks completed successfully, starting installations ..."

    function process_list ()
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
fi


if $SETUP_DOTFILES ; then
    msg "Linking dotfiles in: $SETUP_HOME_DIR ..."
   
    if [ ! -d "dotfiles" ]; then
        fat "dotfiles/ directory is not present."
    fi

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
    cd $ROOT_DIR
fi


if $SETUP_CONFIG ; then
    msg "Linking .config files..."
    cd "dotfiles/config"
    for item in *; do
        echo "Linking: $item -> $SETUP_HOME_DIR/.config/$item ..."
        ln -s "$PWD/$item" "$SETUP_HOME_DIR/.config/$item"
    done
    suc ".config files linked."
    cd $ROOT_DIR
fi

unset $SETUP_USER
unset $SETUP_HOME_DIR

suc "Done! Have a nice day."
