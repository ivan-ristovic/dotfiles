#!/bin/bash

source "utils.sh"

inst $@ tmux 

# Plugin support
gcl https://github.com/tmux-plugins/tpm ${SETUP_HOME_DIR}/.tmux/plugins/tpm
as_user source ${SETUP_HOME_DIR}/.tmux/plugins/tpm/scripts/install_plugins.sh
msg "tmux plugins installed"

