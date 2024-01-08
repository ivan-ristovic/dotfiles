# Installation list processing

Entries from the installation lists are processed in the following manner:
- lines beginning with a `#` sign are treated as comments
- entries prefixed with a `+` sign are treated as an "include" command (useful if same entries are present over multiple installation lists)
- if an entry does not match any of the above cases, it represents a package/script name
    - if there exists a special setup script matching that name in the `install/` directory, it is invoked
        - additionally, if entry is prefixed with a `!` sign, then the installation will be performed after stowing (linking) dotfiles
    - otherwise, it is assumed that there exists a package with such name and installation is attempted using the default package manager
        - specially, for Arch Linux, entries prefixed with `aur:` will use `yay` instead of `pacman` for that entry

