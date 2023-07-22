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
for dir in "${trash_dirs[@]}" ; do 
    msg "Cleaning up junk dir: $dir"
    rm "$SETUP_HOME_USER/${dir:?}" -rf
done

bloat=(
    clipit
    conky
    conky-i3
    manjaro-i3-settings
    manjaro-ranger-settings
    manjaro-zsh-config
    xdg-desktop-portal-gnome
    xfce-terminal
)

for package in "${bloat[@]}" ; do
    uninst "$package"
done

