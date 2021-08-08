alias ...=../..
alias ....=../../..
alias .....=../../../..
alias ......=../../../../..
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias -g C='| cat -Ans | colorize_cat'
alias -g CC='2>&1 | cat -Ans | colorize_cat'
alias -g G='| grep'
alias -g GG='2>&1 | grep'
alias -g H='| head'
alias -g HH='2>&1 | head'
alias -g L='| less'
alias -g LL='2>&1 | less'
alias -g M='| most'
alias -g MM='2>&1 | most'
alias -g NE='2> /dev/null'
alias -g NUL='> /dev/null 2>&1'
alias -g T='| tail'
alias -g TT='2>&1 | tail'
alias _=sudo
alias acp='apt-cache policy'
alias acs='apt-cache search'
alias afind='ack -il'
alias afs='apt-file search --regexp'
alias afu='sudo apt-file update'
alias aga='sudo apt autoclean'
alias agar='sudo apt autoremove'
alias agb='sudo apt build-dep'
alias agc='sudo apt clean'
alias agd='sudo apt dselect-upgrade'
alias age='sudo apt'
alias agi='sudo apt install'
alias agli='apt list --installed'
alias aglu='sudo apt-get -u upgrade --assume-no'
alias agp='sudo apt purge'
alias agr='sudo apt remove'
alias ags='apt source'
alias agu='sudo apt update'
alias agud='sudo apt update && sudo apt dist-upgrade'
alias agug='sudo apt upgrade'
alias aguu='sudo apt update && sudo apt upgrade'
alias allpkgs='dpkg --get-selections | grep -v deinstall'
alias c='cat -ns'
alias conn='~/conn.sh'
ialias cp='cp -i'
alias d='docker'
alias de='docker exec'
alias df='df -kh'
alias diffu='diff --unified'
alias di='docker image'
alias dils='docker image ls'
alias dirm='docker image rm'
alias dlin='docker login -u'
alias dp='docker push'
alias dps='docker ps'
alias dr='docker run -d'
alias drm='docker rm'
alias drmf='docker rm -f'
alias drp='docker run -dp'
alias drv='docker run -d -v'
alias ds='docker stop'
alias du='du -kh'
alias dud='du -d 1 -h'
alias duf='du -sh *'
alias dv='docker volume'
alias dvc='docker volume create'
alias dvi='docker volume inspect'
alias dvls='docker volume ls'
alias dvp='docker volume prune'
alias dvrm'docker volume rm'
ialias e='$EDITOR'
alias fd='fdfind'
alias fm='ranger'
alias getc='curl --continue-at - --location --progress-bar --remote-name --remote-time'
alias getw='wget --continue --progress=bar --timestamping'
ialias grep='grep --color'
alias h=history
alias help=man
alias hgrep='fc -El 0 | grep'
ialias history=omz_history
alias kclean='sudo aptitude remove -P ?and(~i~nlinux-(ima|hea) ?not(~n`uname -r`))'
ialias l='ls -lFh'
ialias lS='ls -1FSsh'
ialias la='ls -lAFh'
alias lart='ls -1Fcart'
alias ldot='ls -ld .*'
ialias ll='ls -lFha'
ialias lr='ls -tRFh'
ialias lrt='ls -1Fcrt'
ialias ls='ls --color=tty'
ialias lt='ls -ltFh'
alias md='mkdir -p'
alias m=make
alias mk='make -B'
ialias mv='mv -i'
alias mydeb='time dpkg-buildpackage -rfakeroot -us -uc'
alias p='ps -f'
alias ppap='sudo ppa-purge'
alias py='python3'
alias rd=rmdir
ialias rm=rm
alias rmf='rm -rf'
alias sa='alias | egrep -i'
alias sgrep='egrep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS}'
alias sortnr='sort -n -r'
alias src='source ~/.zshrc'
alias t='tail -f'
alias td='tmux detach'
ialias type='type -a'
alias unexport=unset
alias vsc='code .'
alias vsca='code --add'
alias vscd='code --diff'
alias vscde='code --disable-extensions'
alias vsced='code --extensions-dir'
alias vscg='code --goto'
alias vscie='code --install-extension'
alias vscl='code --log'
alias vscn='code --new-window'
alias vscr='code --reuse-window'
alias vscu='code --user-data-dir'
alias vscue='code --uninstall-extension'
alias vscv='code --verbose'
alias vscw='code --wait'
alias which-command=whence
alias x=extract

