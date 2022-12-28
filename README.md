# dotfiles

![all-in-one](screenshots/desktop.png)
![all-in-one](screenshots/all-in-one.png)

- **OS**: Arch Linux - Manjaro
- **WM**: i3
- **Shell**: Zsh with oh-my-zsh and powerlevel10k prompt
- **Terminal**: Alacritty
- **Editor**: neovim (Lua config)
- **Session manager**: tmux
- **File manager**: ranger
- **Music player**: mpd with ncmpcpp (TUI), qmmp (GUI)
- **Dotfile manager**: Custom scripts using GNU Stow

This repository contains my personal dotfiles, QOL scripts and binaries, as well as installation scripts for quick setup of Linux systems (primarily for Arch and Ubuntu, since I use them at the moment for my local/cloud machines). Setup can be done by invoking `setup.sh`, a powerful all-in-one setup script. 


## Showcase

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

### Music Player (mpd with ncmpcpp)
![fzf](screenshots/ncmpcpp.png)

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
    - if there exists a special setup script matching that name in the `install/` directory, it is invoked
        - if name is prefixed with a `!` sign, then the installation will be performed after stowing (linking) dotfiles
    - otherwise, it is assumed that there exists a package with such name and installation is attempted using the default package manager
        - specially, for Arch Linux, lines prefixed with `aur:` will use `yay` instead of `pacman` for that entry

Check out `install/` directory for more information on how to use the scripts for automatic mass package installations.

Check out `patches/` directory for more information on how to use the automatic file content patching system.

`bin/` directory is placed on the `PATH` automatically if this dotfiles directory is found in user's home directory.

