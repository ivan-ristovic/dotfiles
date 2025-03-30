# How to write my own script?

The main script will invoke the setup scripts with package manager installation command as an argument. For example, if your package manager is pacman then `pacman -S` will be provided to your script as a command line argument. **Note that the script runs as root**.

The logic of the command is entirely up to you. Feel free (and I encourage you to) ~~steal~~ use the source from [`utils.sh`](../utils.sh) in your own setup scripts (it is automatically imported):
```sh
As an example, consider the script below that sets up `tmux` and `tpm` plugin manager. The file is named `tmux`, so having `tmux` in the installation list will invoke this script:
```sh
#!/bin/bash

inst tmux 

# Plugin support
git clone https://github.com/tmux-plugins/tpm ${SETUP_HOME_DIR}/.tmux/plugins/tpm
log::msg "Installing tmux plugins..."
TMUX_PLUGIN_MANAGER_PATH=${SETUP_HOME_DIR}/.tmux/plugins ${SETUP_HOME_DIR}/.tmux/plugins/tpm/scripts/install_plugins.sh
log::msg "tmux plugins installed"
```
