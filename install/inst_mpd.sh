#!/bin/bash

source "utils.sh"

inst $@ mpd mpc
sudo -u $SETUP_USER mkdir "${XDG_DATA_HOME:-$SETUP_HOME_DIR/.config/}"/mpd

sudo -u $SETUP_USER systemctl --user enable mpd.socket

