# This file contains list of items to install when the setup script is ran.
# Programs/packages are being setup in the same order as in this file.
# Each line represents a single entry!
# Comment out or delete lines corresponding to packages which you do not want to setup automatically

# The entries are processed in the following manner:
#   - if there is a file <entry>.sh present in the `install` directory, use that script to setup the entry
#   - if the statement above does not stand, then use package manager provided as script argument (defaults to `apt`) to setup the package 


updates_arch

yay
snap_arch

bat
base-devel
cmake
#aur_go-chroma
curl
direnv
fd
fzf
git
ffmpeg
firefox_arch
jq
#latex
lftp
nextcloud-client
nvim
#qt5
pandoc
ranger
redshift-minimal
the_silver_searcher
subversion
task
tig
tlp 
tmux
tree
traceroute
valgrind
aur_vscodium-bin
youtubedl
zsh_arch

# Do not delete this line. I cannot trust you to add a new line at the end of the file...
