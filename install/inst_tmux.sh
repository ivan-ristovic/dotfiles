#!/bin/bash

source "utils.sh"

inst $@ tmux 

# Plugin support
gcl https://github.com/tmux-plugins/tpm ${SETUP_HOME_DIR}/.tmux/plugins/tpm
msg "Installing tmux plugins..."
as_user TMUX_PLUGIN_MANAGER_PATH=${SETUP_HOME_DIR}/.tmux/plugins ${SETUP_HOME_DIR}/.tmux/plugins/tpm/scripts/install_plugins.sh
msg "tmux plugins installed"

