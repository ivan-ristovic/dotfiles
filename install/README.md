# How to write my own script?

The main script will invoke the setup scripts with package manager installation command as an argument. For example, if your package manager is pacman then `pacman -S` will be provided to your script as a command line argument.

The name of the script should match the pattern `inst_<name>.sh` where `<name>` will be parsed from the installation list.

The logic of the command is entirely up to you. Feel free (and I encourage you to) ~~steal~~ use the source from `utils.sh` in your own setup scripts, like so:
```sh
source "utils.sh"
```

As an example, consider the script below that sets up `git` wtih custom settings. The file is named `inst_git.sh`, so having `git` in the installation list will invoke this script:
```sh
#!/bin/bash

source "utils.sh"

msg "Installing git"
inst $@ git

msg "Configuring git"

# Consider putting these in the `.gitconfig` instead
# They are here just as an example
git config --global user.email "my@email.com"
git config --global user.name "my-username"
git config --global credential.helper 'cache --timeout=18000' 

suc "Finished setting up git"
```

As another (more realistic) example, check out [inst_zsh.sh](inst_zsh.sh).

If your setup differs for different distributions, you can create multiple files and then use different names for different distributions:
```sh
inst_mypkg_deb.sh
inst_mypkg_arch.sh
```

As an example, check out [inst_docker_arch.sh](inst_docker_arch.sh) and [inst_docker_deb.sh](inst_docker_deb.sh).
