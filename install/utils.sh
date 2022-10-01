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

function is_installed ()
{
    if command -v "$@" &> /dev/null ; then
        return 0
    else
        return 1
    fi
}

function print_already_installed ()
{
    echo "warning: $@ already installed -- skipping"
}

function inst ()
{
	if ! sudo $@; then
		err "An error occurred while executing: $@"
	fi
}

function inst_aur ()
{
	if ! echo y | sudo -u $SETUP_USER yay --needed --noprovides --answerdiff None --answerclean None --mflags "--noconfirm --needed" $@; then
		err "An error occurred while executing: $@"
	fi
}

function rm_comments ()
{
    sed -e 's/[[:space:]]*#.*// ; /^[[:space:]]*$/d' $@
}

function pm_cmd ()
{
    declare -A osinfo;
    osinfo[/etc/redhat-release]="yum -y install"
    osinfo[/etc/arch-release]="pacman --noconfirm --needed -S"
    osinfo[/etc/gentoo-release]='emerge'
    osinfo[/etc/SuSE-release]='zypper install'
    osinfo[/etc/debian_version]="apt-get install -qq"

    for f in ${!osinfo[@]}
    do
        if [[ -f $f ]]; then
            echo "${osinfo["$f"]}"
        fi
    done
}

