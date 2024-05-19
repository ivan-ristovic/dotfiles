# Includes
export SHLIB_ROOT=$HOME/dotfiles/lib/

# Locale
export LANG=en_US.UTF-8
export LANGUAGE=$LANG
export LC_ALL=$LANG
export LC_CTYPE=$LANG
export LC_NAME=$LANG

# Programs
export EDITOR='nvim'
export FILEMGR='thunar'
export FILEMGR_CLI='ranger'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT='-c'
export MPLAYER='ncmpcpp'
export TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'

# Nextcloud
export NC_ROOT=~/Nextcloud
export NC_BACKUP=$NC_ROOT/Backup

# Misc 
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# UI settings
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_STYLE_OVERRIDE=kvantum

