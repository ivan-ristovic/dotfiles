#!/bin/bash

source "include/lib.sh" 
SHLIB_FMT_TIME=true

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
        fmt::msg "An error occurred while uninstalling: $@"
    fi
}

function inst ()
{
    if ! sudo $@; then
        fmt::err "An error occurred while installing: $@"
        sleep 1
        return 1
    fi
}

function inst_silent ()
{
    sudo $@
}

function inst_aur ()
{
    if ! echo y | sudo -u $SETUP_USER yay -S --needed --noconfirm --noprovides --answerdiff None --answerclean None --mflags "--noconfirm --needed" $@; then
        fmt::err "An error occurred while installing from AUR: $@"
        sleep 1
        return 1
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
            return
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
            return 
        fi
    done
}
