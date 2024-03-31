# How to write my own script?

The main script will invoke the setup scripts with package manager installation command as an argument. For example, if your package manager is pacman then `pacman -S` will be provided to your script as a command line argument. **Note that the script runs as root**.

The logic of the command is entirely up to you. Feel free (and I encourage you to) ~~steal~~ use the source from [`utils.sh`](../utils.sh) in your own setup scripts, like so:
```sh
source "../utils.sh"
```
That way you can use functions such as `as_user` (to execute commands as the setup user instead of root) or `gcl` (to clone a git repository as the setup user).

As an example, consider the script below that sets up `tmux` and `tpm` plugin manager. The file is named `tmux`, so having `tmux` in the installation list will invoke this script:
```sh
#!/bin/bash

source "../utils.sh"

inst $@ tmux 

# Plugin support
gcl https://github.com/tmux-plugins/tpm ${SETUP_HOME_DIR}/.tmux/plugins/tpm
log::msg "Installing tmux plugins..."
as_user TMUX_PLUGIN_MANAGER_PATH=${SETUP_HOME_DIR}/.tmux/plugins ${SETUP_HOME_DIR}/.tmux/plugins/tpm/scripts/install_plugins.sh
log::msg "tmux plugins installed"
```

To distinguish different procedures on different distributions, you can use different filenames (e.g., use a different suffix). Check out [docker_arch.sh](docker_arch.sh) and [docker_deb.sh](docker_deb.sh) for an example.
