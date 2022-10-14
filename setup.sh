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
    echo -e "\t--debug: runs the script in debug mode"
    echo
    echo -e "\t--packages: install packages"
    echo -e "\t--dotfiles: link dotfiles"
    echo -e "\t--patch: perform patches from patches/ dir"
    echo -e "\t--all: do all of the above (default)"
    exit 0
}

SETUP_OVERRIDE=false
SETUP_PACKAGES=false
SETUP_DOTFILES=false
SETUP_PATCHES=false

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
        --patch)
            SETUP_OVERRIDE=true
            SETUP_PATCHES=true
            ;;
        --debug)
            inf "debug mode enabled"
            set -xe; 
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
    SETUP_PATCHES=true
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
            sleep 1
        done
    }

    process_list "$INSTALL_LIST"
    suc "Installations finished."
fi


if $SETUP_DOTFILES ; then
    source link.sh $SETUP_HOME_DIR
fi

if $SETUP_PATCHES ; then
    if [ ! -d "patches" ]; then
        err "patches/ directory is not present."
    fi
    cd patches
    if [ -f "patch.sh" ]; then
        source patch.sh
    else
        err "patches/patch.sh script is not present."
    fi
    cd $SETUP_HOME_DIR
fi

unset SETUP_USER
unset SETUP_HOME_DIR

suc "Done! Have a nice day."

