# How to write my own script?

The main script will invoke the setup scripts with package manager installation command as an argument. For example, if your package manager is pacman then `pacman -S` will be provided to your script as a command line argument. **Note that the script runs as root**.

The logic of the command is entirely up to you. Feel free (and I encourage you to) ~~steal~~ use the source from `utils.sh` in your own setup scripts, like so:
```sh
source "utils.sh"
```
That way you can use functions such as `as_user` (to execute commands as the setup user instead of root) or `gcl` (to clone a git repository as the setup user).

As an example, consider the script below that sets up `git` wtih custom settings. The file is named `git.sh`, so having `git` in the installation list will invoke this script:
```sh
#!/bin/bash

source "utils.sh"

inst $@ git

# Consider putting these in the `.gitconfig` instead
# They are here just as an example
git config --global user.email "my@email.com"
git config --global user.name "my-username"
git config --global credential.helper 'cache --timeout=18000' 
```

As another (more realistic) example, check out [inst_zsh.sh](inst_zsh.sh).

If your setup differs for different distributions, you can create multiple files and then use different names for different distributions:
```sh
mypkg_deb.sh
mypkg_arch.sh
```

As an example, check out [inst_docker_arch.sh](inst_docker_arch.sh) and [inst_docker_deb.sh](inst_docker_deb.sh).
