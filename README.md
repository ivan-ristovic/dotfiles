# dotfiles

This repository contains my personal dotfiles and automated setup scripts for fresh Linux systems (primary goal for Arch and Ubuntu since I use them at the moment).

## How it works?

Invoking `setup.sh` (with optional username and package list) will start the setup process as follows:
- Identify user and environment (e.g. package manager command)
- Install entries from the installation list
- Link dotfiles and `.config` files (from the `dotfiles/` directory) to user's home directory

Packages are set up from the package lists in the following manner:
- lines beginning with a `#` sign are treated as comments
- lines beginning with a `+` sign are treated as an "include" command (useful if same entries are present over multiple installation lists)
- if a line does not match any of the above cases, it represents a package/script name
    - if there exists a special setup script matching that name name in the `install/` directory, it is invoked
    - otherwise, it is assumed that there exists a package with such name and installation is attempted using the default package manager
        - specially, for Arch Linux, if lines starting with `aur:` will use `yay` instead of `pacman` for that entry

Check out `install/` directory for more information on how to use the scripts for automatic mass package installations.

