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
alias B='| bat'
alias BB='2>&1 | bat'
alias C='| bat'
alias CC='2>&1 | bat'
alias G='| grep'
alias GG='2>&1 | grep'
alias H='| head'
alias HH='2>&1 | head'
alias L='| less'
alias LC='| wc -l'
alias LL='2>&1 | less'
alias M='| most'
alias MM='2>&1 | most'
alias NE='2> /dev/null'
alias NUL='> /dev/null 2>&1'
alias T='| tail'
alias TT='2>&1 | tail'
alias _=sudo
alias aga='ag -a'
alias aurs='yay -S'
alias aurq='yay -Q'
alias aurr='yay -R'
alias auru='yay -U'
alias aurua='yay -Syu'
alias b='bat'
alias c='cat -ns'
alias cp='cp -i'
alias d='docker'
alias dc='docker-compose'
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'
alias dcl='docker-compose logs -f'
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
alias dvrm='docker volume rm'
alias e='$EDITOR'
alias fda='fd --no-ignore'
alias fm='ranger'
alias getc='curl --continue-at - --location --progress-bar --remote-name --remote-time'
alias getw='wget --continue --progress=bar --timestamping'
alias gsa='git submodule add'
alias grhhh='git reset --hard @{u}'
alias grep='grep --color'
alias h=history
alias help=man
alias hgrep='fc -El 0 | grep'
alias k='kill -9'
alias l='ls -lFh'
alias lS='ls -1FSsh'
alias la='ls -lAFh'
alias lart='ls -1Fcart'
alias ldot='ls -ld .*'
alias ll='ls -lFha'
alias lr='ls -tRFh'
alias lrt='ls -1Fcrt'
alias ls='ls --color=tty'
alias lt='ls -ltFh'
alias m=make
alias map='xargs -n1'
alias md='mkdir -p'
alias mk='make -B'
alias mv='mv -i'
alias p='ps -f'
alias pacs='sudo pacman -S'
alias pacq='sudo pacman -Q'
alias pacr='sudo pacman -R'
alias pacu='sudo pacman -U'
alias pacua='sudo pacman -Syu'
alias py='python3'
alias rd=rmdir
alias rma='rm *'
alias rmf='rm -rf'
alias sa='alias | egrep -i'
alias sortnr='sort -n -r'
alias src='source ~/.zshrc'
alias td='tmux detach'
alias tsk='task'
alias tska='task add'
alias tskad='task add due:'
alias tskadt='task add due:tomorrow'
alias tskf='task done'
alias tskd='task delete'
alias tskl='task list'
alias tskm='task modify'
alias type='type -a'
alias unexport=unset
alias uz=ua
alias ux=extract
alias vim='nvim'
alias vsc='codium .'
alias vsca='codium --add'
alias vscd='codium --diff'
alias vscde='codium --disable-extensions'
alias vsced='codium --extensions-dir'
alias vscg='codium --goto'
alias vscie='codium --install-extension'
alias vscl='codium --log'
alias vscn='codium --new-window'
alias vscr='codium --reuse-window'
alias vscu='codium --user-data-dir'
alias vscue='codium --uninstall-extension'
alias vscv='codium --verbose'
alias vscw='codium --wait'
alias which-command=whence
alias ytdl=youtube-dl
alias ytdlmp3='youtube-dl --extract-audio --audio-format=mp3'
alias ytdlmp3pl='youtube-dl --extract-audio --audio-format=mp3 -o "%(title)s.%(ext)s"'

