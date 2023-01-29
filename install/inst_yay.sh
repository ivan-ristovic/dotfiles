#!/bin/bash

source "utils.sh"

inst_silent $@ yay
if [ $? -ne 0 ]; then
    inst $@ git base-devel
    yaydir=/opt/yay
    mkdir $yaydir
    chown user:user $yaydir
    gcl https://aur.archlinux.org/yay-bin.git $yaydir
    pushd $yaydir
    as_user makepkg -si --noconfirm --needed
    popd
fi

