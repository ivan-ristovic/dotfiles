#!/bin/bash

source "utils.sh"

inst_aur $@ openrazer-meta polychromatic
sudo gpasswd -a "$SETUP_USER" plugdev

msg "Do not forget to install linux-headers"

