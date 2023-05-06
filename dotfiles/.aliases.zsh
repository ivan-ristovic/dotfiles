alias ...=../..
alias .....=../../..
alias .....=../../../..
alias ......=../../../../..
alias cd1='cd -1'
alias cd2='cd -2'
alias cd3='cd -3'
alias cd4='cd -4'
alias cd5='cd -5'
alias cd6='cd -6'
alias cd7='cd -7'
alias cd8='cd -8'
alias cd9='cd -9'
alias -g B='| bat'
alias -g BB='2>&1 | bat'
alias -g C='| bat'
alias -g CC='2>&1 | bat'
alias -g COL='| column -t'
alias -g G='| grep'
alias -g GG='2>&1 | grep'
alias -g H='| head'
alias -g HH='2>&1 | head'
alias -g L='| less'
alias -g LC='| wc -l'
alias -g LL='2>&1 | less'
alias -g M='| most'
alias -g MM='2>&1 | most'
alias -g NE='2> /dev/null'
alias -g NUL='> /dev/null 2>&1'
alias -g T='| tail'
alias -g TT='2>&1 | tail'
alias _=sudo
alias aga='ag -aU --hidden'
alias aurs='yay -S'
alias aurq='yay -Q'
alias aurr='yay -R'
alias auru='yay -U'
alias aurua='yay -Syu'
alias b='bat'
alias bench='hyperfine'
alias c='cat -ns'
ialias cp='cp -i'
alias d='docker'
alias dc='docker-compose'
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'
alias dcl='docker-compose logs -f'
alias de='docker exec'
alias df='duf'
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
alias du='dust'
alias dv='docker volume'
alias dvc='docker volume create'
alias dvi='docker volume inspect'
alias dvls='docker volume ls'
alias dvp='docker volume prune'
alias dvrm'docker volume rm'
ialias e='$EDITOR'
alias fda='fd -H --no-ignore'
ialias fm='$FILEMGR_CLI'
alias getc='curl --continue-at - --location --progress-bar --remote-name --remote-time'
alias getw='wget --continue --progress=bar --timestamping'
alias gsa='git submodule add'
alias grhhh='git reset --hard @{u}'
ialias grep='grep --color'
alias h=history
alias hd='hexdump -C'
alias help=man
alias hgrep='fc -El 0 | grep'
ialias history=omz_history
alias k='kill -9'
ialias l='ls -lFh'
ialias lS='ls -1FSsh'
ialias la='ls -lAFh'
alias lart='ls -1Fcart'
alias ldot='ls -ld .*'
alias lg='lazygit'
ialias ll='ls -lFha'
ialias lr='ls -tRFh'
ialias lrt='ls -1Fcrt'
ialias ls='ls --color=tty'
ialias lt='ls -ltFh'
alias m=make
alias map='xargs -n1'
alias md='mkdir -p'
alias mk='make -B'
ialias mp='$MPLAYER'
ialias mv='mv -i'
alias p='ps -f'
alias pacs='sudo pacman -S'
alias pacq='sudo pacman -Q'
alias pacr='sudo pacman -R'
alias pacu='sudo pacman -U'
alias pacua='sudo pacman -Syu'
alias ports='netstat -tulanp'
alias py='python3'
alias rd=rmdir
alias rma='rm *'
alias rmf='rm -rf'
alias rmfa='rm -rf *'
alias sa='alias | egrep -i'
alias sortnr='sort -n -r'
alias src='exec zsh'
alias td='tmux detach'
alias tree='br'
alias tsk='taskwarrior-tui'
alias tska='task add'
alias tskad='task add due:'
alias tskadt='task add due:tomorrow'
alias tskd='task done'
alias tskl='task list'
alias tskm='task modify'
alias tskrm='task delete'
ialias type='type -a'
alias unexport=unset
alias uz=ua
alias ux=extract
alias vim='nvim'
alias vsc='codium .'
alias which-command=whence
alias ytdl=yt-dlp

