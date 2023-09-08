#!/bin/bash

source "utils.sh"

inst $@ fuse2 gtkmm linux-headers ncurses libcanberra pcsclite

# sudo ./script.bundle --console --required --eulas-agreed
yay -S --noconfirm --needed  vmware-workstation

services=vmware-networks.service vmware-usbarbitrator.service vmware-hostd.service
sudo systemctl enable $services
sudo systemctl start $services

sudo vmware-modconfig --console --install-all
sudo modprobe -a vmw_vmci vmmon


