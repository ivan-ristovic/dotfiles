#!/bin/bash

PROMPT=">"
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

function suc ()
{
    echo -e "${GREEN}${PROMPT} suc: ${NC}$@"
}

function msg ()
{
    echo "${PROMPT} inf: $@"
}

function err ()
{
    echo -e "${RED}${PROMPT} err: ${NC}$@" 
}

function fat ()
{
    err $@
    exit 1
}

function inst ()
{
	if ! $@ > /dev/null; then
		err "An error occurred while executing: $@"
	fi
}

function rm_comments ()
{
    sed -e 's/[[:space:]]*#.*// ; /^[[:space:]]*$/d' $@
}

function pm_cmd ()
{
    # TODO I currently need it to setup ubuntu-ish distros, this should be updated to work for others as well
    declare -A osinfo;
    osinfo[/etc/redhat-release]=yum
    osinfo[/etc/arch-release]=pacman
    osinfo[/etc/gentoo-release]=emerge
    osinfo[/etc/SuSE-release]=zypp
    osinfo[/etc/debian_version]="apt-get install"

    for f in ${!osinfo[@]}
    do
        if [[ -f $f ]]; then
            echo ${osinfo[$f]}
        fi
    done
}

# http://djm.me/ask
function ask() 
{
    while true; do

        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -n "$1 [$prompt] "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read REPLY </dev/tty

        # Default?
        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi

        # Check if the reply is valid
        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}