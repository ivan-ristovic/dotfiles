#!/bin/bash

source "utils.sh"

inst $@ tmux 
git clone https://github.com/tmux-plugins/tpm ${SETUP_HOME_DIR}/.tmux/plugins/tpm

