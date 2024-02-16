#!/bin/bash

if [ "$DOTFILES_UTILS_SOURCED" == true ]; then
    return
fi
export DOTFILES_UTILS_SOURCED=true

source "$SHLIB_ROOT/lib.sh" 
SHLIB_FMT_TIME=true

function as_user ()
{
    sudo -u "$SETUP_USER" $@
}

function gcl ()
{
    as_user git clone $@
}

function uninst ()
{
    if ! sudo $PM_UNINSTALL_CMD $@; then
        fmt::wrn "An error occurred while uninstalling: $@"
    fi
}

function inst ()
{
    if ! inst_silent $@; then
        fmt::err "An error occurred while installing: $@"
    fi
}

function inst_silent ()
{
    sudo $PM_INSTALL_CMD $@
}

function inst_aur ()
{
    if ! echo y | sudo -u "$SETUP_USER" yay -S --sudoloop --needed --noconfirm --provides=false --answerdiff None --answerclean None --mflags "--noconfirm --needed" $@; then
        fmt::err "An error occurred while installing from AUR: $@"
    fi
}

function inst_pip ()
{
    if [ -f /etc/arch-release ]; then
        local args=("$@")
        inst "${args[@]/#/python-}"
        unset args
    else
        pip install "$@"
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

    for f in "${!osinfo[@]}"; do
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

    for f in "${!osinfo[@]}"; do
        if [[ -f $f ]]; then
            echo "${osinfo["$f"]}"
            return 
        fi
    done
}

export PM_INSTALL_CMD=$(pm_cmd)
export PM_UNINSTALL_CMD=$(pm_uninst_cmd)

