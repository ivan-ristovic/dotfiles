#!/bin/bash

source "utils.sh"

trash_dirs=(
    Desktop
    Documents
    Downloads
    Music
    Pictures
    Public
    Templates
    Videos
    .i3
    .config/dunst
    .config/Kvantum
)
for dir in ${trash_dirs[@]}; do 
    msg "Cleaning up junk dir: $dir"
    rm $SETUP_HOME_USER/$dir -rf
done

uninst clipit
uninst conky-i3 conky manjaro-i3-settings
uninst xfce-terminal

