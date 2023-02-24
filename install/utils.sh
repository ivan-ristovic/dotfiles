#!/bin/bash

PROMPT=">"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;36m'
NC='\033[0m'

function suc ()
{
    echo -e "${GREEN}${PROMPT} suc: ${NC}$@"
}

function msg ()
{
    echo -e "${YELLOW}${PROMPT} inf: ${NC}$@"
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

function as_user ()
{
    sudo -u $SETUP_USER $@
}

function gcl ()
{
    as_user git clone $@
}

function uninst ()
{
    PMU=$(pm_uninst_cmd)
    if ! sudo $PMU $@; then
        msg "An error occurred while uninstalling: $@"
    fi
}

function inst ()
{
    if ! sudo $@; then
        err "An error occurred while installing: $@"
        sleep 5
    fi
}

function inst_silent ()
{
    sudo $@
}

function inst_aur ()
{
    if ! echo y | sudo -u $SETUP_USER yay -S --needed --noprovides --answerdiff None --answerclean None --mflags "--noconfirm --needed" $@; then
        err "An error occurred while installing from AUR: $@"
        sleep 5
    fi
}

function rm_comments ()
{
    sed -e 's/[[:space:]]*#.*// ; /^[[:space:]]*$/d' $@
}

function read_list ()
{
    echo $(rm_comments $1)
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

function pm_uninst_cmd ()
{
    declare -A osinfo;
    osinfo[/etc/redhat-release]="yum -y remove"
    osinfo[/etc/arch-release]="pacman --noconfirm -R"
    osinfo[/etc/gentoo-release]='emerge --deselect'
    osinfo[/etc/SuSE-release]='zypper remove'
    osinfo[/etc/debian_version]="apt-get remove -qq"

    for f in ${!osinfo[@]}
    do
        if [[ -f $f ]]; then
            echo "${osinfo["$f"]}"
        fi
    done
}
