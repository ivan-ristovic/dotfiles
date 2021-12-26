# dotfiles

This repository contains my personal dotfiles and automated setup scripts for fresh Linux systems (primary goal for Arch and Ubuntu since I use them at the moment).

## How it works?

Invoking `setup.sh` with username and package list will start the setup process as follows:
- Identify user and environment (e.g. package manager command)
- Setup packages from the package list
- Link dotfiles from `dotfiles/` to user's home

Packages are set up from the package lists in the following manner:
- any lines beginning with a `#` sign are treated as comments
- if a line begins with a `+` sign, a file whose name are the remaining line contents is included in the list
- otherwise, the line represents a package name
    - if there is a special setup script with such name in the `install/` directory, then invoke that script
    - otherwise, attempt to install a package with such name using the default package manager
        - for Arch Linux, if a line starts with `aur_`, then `yay` is used instead of `pacman` for that package

Check out `install/` directory for more information on how to use the scripts for automatic mass package installations.

