#!/bin/bash

source "utils.sh"

inst $@ mpd mpc
as_user mkdir -p "$SETUP_HOME_DIR/.config/mpd"

as_user systemctl --user enable mpd.socket
