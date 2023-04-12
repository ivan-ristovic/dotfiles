#!/bin/bash

source "utils.sh"

inst_aur nordvpn-cli-bin

sudo usermod -aG nordvpn $SETUP_USER
sudo systemctl enable nordvpnd
sudo systemctl set autoconnect on

