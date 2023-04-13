#!/bin/bash

source "utils.sh"

inst $@ binutils

# Check if yay is already available in the repository
if ! inst_silent $@ yay ; then
    inst $@ base-devel
    yaydir=/opt/yay
    mkdir -p $yaydir
    chown $SETUP_USER:$SETUP_USER $yaydir
    gcl https://aur.archlinux.org/yay-bin.git $yaydir
    pushd $yaydir
    as_user makepkg -si --noconfirm --needed
    popd
fi

