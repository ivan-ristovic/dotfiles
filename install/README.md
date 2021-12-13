# How to write my own script?

The main script will invoke the setup scripts with package manager installation command as an argument. For example, if your package manager is pacman then `pacman -S` will be provided to your script as a command line argument.

The name of the script should match the pattern `inst_<name>.sh` where `<name>` will be parsed from the installation list.

The logic of the command is entirely up to you. Feel free (and I actually encourage you to) ~~steal~~ use the source from `utils.sh` in your own setup scripts, like so:
```sh
source "utils.sh"
```

Below you will find a complete example which sets up `git`. The file is therefore named `inst_git.sh`.

```sh
#!/bin/bash

source "utils.sh"

inst $@ git
git config --global user.email "my@email.com"
git config --global user.name "my-username"
git config --global credential.helper 'cache --timeout=18000' 
```

If your setup differs for different distributions, you can create multiple files and then use different names for different distributions:
```sh
inst_mypkg_deb.sh
inst_mypkg_arch.sh
```

