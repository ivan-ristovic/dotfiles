# dotfiles

This repository contains my personal dotfiles, QOL scripts and binaries, as well as installation scripts for fresh Linux systems (primarily for Arch and Ubuntu, since I use them at the moment for my local/cloud machines).

The goal of this repository is to trivialize fresh system setup and configuration. Setup can be done by invoking `setup.sh`, a powerful all-in-one setup script that performs mass package installation, configuration linking and more. This repository is not only my personal configuration store, it includes tools and QOL scripts that one might find useful. 


## Showcase

### All in one image (zsh, nvim, fzf, ranger, forgit, etc.)
![all-in-one](screenshots/all-in-one.png)

### Shell (zsh with oh-my-zsh, p10k prompt)
![zsh](screenshots/zsh.png)
![prompt](screenshots/prompt.png)

My custom (additional) features:
- Integration with tmux, nvim, fzf...
- Automatic [alias expansion](dotfiles/.zshrc)
- QOL [aliases](dotfiles/.aliases.zsh) and [functions](bin)

### Session Manager (tmux)
![tmux](screenshots/tmux.png)

### Editor (plugin-enriched Neovim with zsh, git and fzf integration)
![nvim](screenshots/nvim.png)

### Search (fzf fuzz search integrated with zsh, nvim and forgit; fd and ag)
![fzf](screenshots/fzf.png)

### File Manager (Ranger)
![ranger](screenshots/ranger.png)


## How does it work?

Invoking `setup.sh` with username and package list will start the setup process that performs the following steps:
- Environment identification (e.g., the package manager)
- Installation list processing
- Dotfiles and `.config` files (from the `dotfiles/` directory) linking to user's home directory using [GNU Stow](https://www.gnu.org/software/stow/) (can be done manually by invoking `link.sh`)

It is possible to perform only some of the above steps by passing options (such as `--dotfiles` or `--packages`). Run `setup.sh --help` for more information.

Additional scripts are available for maintenance:
- `pull.sh` - stashes local changes, pulls the remote and re-stows dotfiles
- `link.sh` - re-stows dotfiles

Entries from the installation lists are processed in the following manner:
- lines beginning with a `#` sign are treated as comments
- lines beginning with a `+` sign are treated as an "include" command (useful if same entries are present over multiple installation lists)
- if a line does not match any of the above cases, it represents a package/script name
    - if there exists a special setup script matching that name name in the `install/` directory, it is invoked
    - otherwise, it is assumed that there exists a package with such name and installation is attempted using the default package manager
        - specially, for Arch Linux, lines prefixed with `aur:` will use `yay` instead of `pacman` for that entry

Check out `install/` directory for more information on how to use the scripts for automatic mass package installations.

`bin/` directory is placed on the `PATH` automatically if this dotfiles directory is found in user's home directory.

