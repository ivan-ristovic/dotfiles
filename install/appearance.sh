#!/bin/bash

source "utils.sh"

as_user unzip -q -o "$SETUP_HOME_DIR/.themes/*.zip" -d "$SETUP_HOME_DIR/.themes"
as_user tar --xz -xf "$SETUP_HOME_DIR/.icons/*.tar.xz" -C "$SETUP_HOME_DIR/.icons"

