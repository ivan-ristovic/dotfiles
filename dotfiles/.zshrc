######################### TMUX #########################

# Start tmux. Has to be before p10k instant prompt initialization!
if command -v tmux > /dev/null && [ -z "$TMUX" ]; then
    exec tmux new-session -A
fi

######################### P10K #########################

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

####################### PATCHES #######################

# Redefine COMPLETION_WAITING_DOTSas it messes with fzf-tab
expand-or-complete-with-dots() {
    COMPLETION_WAITING_DOTS="%F{red}…%f"
    printf '\e[?7l%s\e[?7h' "${(%)COMPLETION_WAITING_DOTS}"
    zle expand-or-complete
    # zle redisplay <--- this causes lines to be eaten
}
zle -N expand-or-complete-with-dots
bindkey -M emacs "^I" expand-or-complete-with-dots
bindkey -M viins "^I" expand-or-complete-with-dots
bindkey -M vicmd "^I" expand-or-complete-with-dots

######################### ENV #########################

ZSH_TMUX_AUTOSTART=true
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd/mm/yyyy"
HIST_SIZE=500000
setopt HIST_IGNORE_SPACE

fpath=(~/.config/zsh/completion $fpath)

####################### PLUGINS #######################

if [ ! -d "$HOME"/.oh-my-zsh/ ]; then
    echo "Installing oh-my-zsh ..."
    git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME"/.oh-my-zsh/
fi

plugins=(
  colored-man-pages         # man highlighting
  command-not-found         # "did you mean" on cmd 404
  copybuffer                # ctrl+o to copy buffer to clip
  copyfile                  # copies file to clip
  copypath                  # copies $(pwd) to clip
  cp                        # cpv alias to use rsync
  direnv                    # .env files for each dir
  dirhistory                # alt+arrows to navigate dirs
  docker                    # docker completion and aliases
  docker-compose            # docker-compose completion and aliases
  encode64                  # encode64/decode64 aliases
  extract                   # extract alias
  fancy-ctrl-z              # ctrl+z for fg and bg
  fzf                       # fzf completion
  git                       # git completion and aliases
  mx
  per-directory-history     # ctrl+g to toggle global/dir history
  python                    # python aliases and venv management
  rsync                     # rsync aliases
  sudo                      # esc to add/remove sudo
  taskwarrior               # taskw completion
  tmux                      # tmux completion and aliases
  universalarchive          # ua
  wd                        # directory warp
  # zsh-autosuggestions
  zsh-interactive-cd        # tab completion for cd
)

source $HOME/.oh-my-zsh/oh-my-zsh.sh

ZINIT_HOME="${HOME}/.zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-completions       
zinit light zdharma-continuum/zsh-diff-so-fancy
zinit light wfxr/forgit
# zinit light jeffreytse/zsh-vi-mode
zinit light zsh-users/zsh-syntax-highlighting
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light Aloxaf/fzf-tab

########################## MISC ###########################

# Vim mode cursors
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE

# Should reload fast-syntax-highlighting theme?
__fsh_theme_dir="$HOME/.config/zsh/highlighting/"
__fsh_theme_mod_time=$(date -r "$__fsh_theme_dir/theme.ini" "+%s")
if [ -f "$__fsh_theme_dir/.theme-set" ]; then 
    __fsh_saved_mod_time=$(cat "$__fsh_theme_dir/.theme-set")
else
    __fsh_saved_mod_time=$(date "+%s")
fi
if [ $__fsh_saved_mod_time != $__fsh_theme_mod_time ]; then
    fast-theme "$HOME/.config/zsh/highlighting/theme.ini" > /dev/null
    echo $__fsh_theme_mod_time > "$HOME/.config/zsh/highlighting/.theme-set"
fi
unset __fsh_theme_dir
unset __fsh_theme_mod_time
unset __fsh_saved_mod_time

# Git support for fzf (Ctrl+G -> key)
if [[ -r "$HOME/.fzf-git.zsh" ]]; then
    source "$HOME/.fzf-git.zsh"
fi

# Configuration for zsh-tab
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
# zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-flags --color=pointer:#5f87af,marker:#48f513 --border --cycle --info inline --multi --bind alt-backspace:toggle
zstyle ':fzf-tab:*' fzf-pad 3
zstyle ':fzf-tab:*' switch-group '<' '>'
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

######################## LS COLORS ########################

# Simple ls colors if not using eza
# LS_COLORS="ow=01;36;40" && export LS_COLORS

# Generated with utils/gen-ls-colors, for use with eza
LS_COLORS="di=1;34:ln=0;36:pi=0;33:bd=1;33:cd=1;33:so=1;31:ex=1;32:*README=0;4;37:*README.txt=0;4;37:*README.md=0;4;37:*readme.txt=0;4;37:*readme.md=0;4;37:*.ninja=0;33:*Makefile=0;33:*Cargo.toml=0;33:*SConstruct=0;33:*CMakeLists.txt=0;33:*build.gradle=0;33:*pom.xml=0;33:*Rakefile=0;33:*package.json=0;33:*Gruntfile.js=0;33:*Gruntfile.coffee=0;33:*BUILD=0;33:*BUILD.bazel=0;33:*WORKSPACE=0;33:*build.xml=0;33:*Podfile=0;33:*webpack.config.js=0;33:*meson.build=0;33:*composer.json=0;33:*RoboFile.php=0;33:*PKGBUILD=0;33:*Justfile=0;33:*Procfile=0;33:*Dockerfile=0;33:*Containerfile=0;33:*Vagrantfile=0;33:*Brewfile=0;33:*Gemfile=0;33:*Pipfile=0;33:*build.sbt=0;33:*mix.exs=0;33:*bsconfig.json=0;33:*tsconfig.json=0;33:*.zip=0;31:*.tar=0;31:*.Z=0;31:*.z=0;31:*.gz=0;31:*.bz2=0;31:*.a=0;31:*.ar=0;31:*.7z=0;31:*.iso=0;31:*.dmg=0;31:*.tc=0;31:*.rar=0;31:*.par=0;31:*.tgz=0;31:*.xz=0;31:*.txz=0;31:*.lz=0;31:*.tlz=0;31:*.lzma=0;31:*.deb=0;31:*.rpm=0;31:*.zst=0;31:*.lz4=0;31" && export LS_COLORS

# Colors for eza
EZA_COLORS="ur=38;5;248:uw=38;5;248:ux=38;5;210:ue=38;5;248:gr=38;5;248:gw=38;5;248:gx=38;5;210:tr=38;5;150:tw=38;5;216:tx=38;5;210:sn=37:uu=37:gu=37:un=1;37:gn=1;37:da=37" && export EZA_COLORS

# Make cd use the ls colours
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

#######################  COMPLETION  #######################

# zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit
compinit

# Replay compdefs
zinit cdreplay -q

# Alt-Tab for quoted completion
# `showkey -a` can be used to help find keymaps
autoload -Uz quote-and-complete-word
zle -N quote-and-complete-word
bindkey '^[\t' quote-and-complete-wordq

####################### ALIAS SUPPORT #######################

# Blank aliases
typeset -a baliases
baliases=()

balias() {
  alias $@
  args="$@"
  args=${args%%\=*}
  baliases+=(${args##* })
}

# Ignored aliases
typeset -a ialiases
ialiases=()

ialias() {
  alias $@
  args="$@"
  args=${args%%\=*}
  ialiases+=(${args##* })
}

# Functionality
expand-alias-space() {
  [[ $LBUFFER =~ "\<(${(j:|:)baliases})\$" ]]; insertBlank=$?
  if [[ ! $LBUFFER =~ "\<(${(j:|:)ialiases})\$" ]]; then
    zle _expand_alias
  fi
  zle self-insert
  if [[ "$insertBlank" = "0" ]]; then
    zle backward-delete-char
  fi
}
zle -N expand-alias-space

expand-alias-enter() {
  zle expand-alias-space
  zle backward-delete-char
  zle accept-line
}
zle -N expand-alias-enter

bindkey " " expand-alias-space
bindkey "^M" expand-alias-enter
bindkey -M isearch " " magic-space

source ~/.aliases
source ~/.functions

smartdots() {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
  else
    LBUFFER+=.
  fi
}
zle -N smartdots
bindkey . smartdots

############## COND CONF #############

if [ -d "$HOME/.zsh.d" ] ; then
    for dir in "$HOME/.zsh.d"/*/ ; do 
        if [ -f "$dir/.include" ] && "$dir/.include" ; then
            for f in "$dir"/* ; do
                source "$f"
            done
        fi
    done
    unset dir
    unset f
fi

################ MISC ################

# Man search with fzf (Ctrl+H)
fzf-man-widget() {
  batman="man {1} | col -bx | bat --language=man --plain --color always "
   man -k . | sort \
   | awk -v cyan=$(tput setaf 6) -v blue=$(tput setaf 4) -v res=$(tput sgr0) -v bld=$(tput bold) '{ $1=cyan bld $1; $2=res blue;} 1' \
   | fzf  \
      -q "$1" \
      --ansi \
      --tiebreak=begin \
      --prompt='man > '  \
      --preview-window '50%,rounded,<50(up,85%,border-bottom)' \
      --preview "${batman}" \
      --bind "enter:execute(man {1})" \
      # --bind "alt-c:+change-preview(cht {1})+change-prompt(cht > )" \
      # --bind "alt-m:+change-preview(${batman})+change-prompt(man > )" \
      # --bind "alt-t:+change-preview(tldr --color=always {1})+change-prompt(tldr > )"
  zle reset-prompt
}
bindkey '^h' fzf-man-widget
zle -N fzf-man-widget

# Smart mv 
autoload -U zmv

################ P10K ################

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


################ OL ##################
# has to be at the end
source ${OL_SCRIPTS}/shell_rc.sh
