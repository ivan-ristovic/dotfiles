################ TMUX ################

# Start tmux. Has to be before p10k instant prompt initialization!
if command -v tmux > /dev/null && [ -z "$TMUX" ]; then
  exec tmux new-session -A
fi

################ P10K ################

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

############### ZSH ##################

export ZSH="$HOME/.oh-my-zsh"
# ZSH_CUSTOM=/path/to/new-custom-folder
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_TMUX_AUTOSTART=true
export ZSH_COLORIZE_TOOL=chroma
export ZSH_COLORIZE_STYLE="solarized-dark"
export ZSH_COLORIZE_CHROMA_FORMATTER=terminal256

# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

fpath=(~/.config/zsh/completion $fpath)

setopt HIST_IGNORE_SPACE
HIST_STAMPS="dd/mm/yyyy"
HIST_SIZE=500000

plugins=(
  colored-man-pages         # man highlighting
  colorize                  # sh highlighting
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
  fd                        # fd completion
  fzf                       # fzf completion
  git                       # git completion and aliases
  nmap                      # nmap aliases
  per-directory-history     # ctrl+g to toggle global/dir history
  python                    # python aliases and venv management
  rsync                     # rsync aliases
  sudo                      # esc to add/remove sudo
  taskwarrior               # taskw completion
  tmux                      # tmux completion and aliases
  # tmuxinator                # tmuxinator completion and aliases
  universalarchive          # ua
  wd                        # directory warp
  # web-search                # aliases for search engines
  # zsh-autosuggestions
  zsh-interactive-cd        # tab completion for cd 
  zsh-syntax-highlighting   # must be last!
)

source $ZSH/oh-my-zsh.sh

######################### ZPLUG ##########################

source ~/.zplug/init.zsh

zplug 'wfxr/forgit'

if ! zplug check; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

########################## MISC #############################

# Git support for fzf
if [[ -r "$HOME/.fzf-git.zsh" ]]; then
  source "$HOME/.fzf-git.zsh"
fi

########################## LS COLORS ########################

# Simple ls colors if not using eza
# LS_COLORS="ow=01;36;40" && export LS_COLORS

# Generated with utils/gen-ls-colors, for use with eza
LS_COLORS="di=1;34:ln=0;36:pi=0;33:bd=1;33:cd=1;33:so=1;31:ex=1;32:*README=1;4;33:*README.txt=1;4;33:*README.md=1;4;33:*readme.txt=1;4;33:*readme.md=1;4;33:*.ninja=1;4;33:*Makefile=1;4;33:*Cargo.toml=1;4;33:*SConstruct=1;4;33:*CMakeLists.txt=1;4;33:*build.gradle=1;4;33:*pom.xml=1;4;33:*Rakefile=1;4;33:*package.json=1;4;33:*Gruntfile.js=1;4;33:*Gruntfile.coffee=1;4;33:*BUILD=1;4;33:*BUILD.bazel=1;4;33:*WORKSPACE=1;4;33:*build.xml=1;4;33:*Podfile=1;4;33:*webpack.config.js=1;4;33:*meson.build=1;4;33:*composer.json=1;4;33:*RoboFile.php=1;4;33:*PKGBUILD=1;4;33:*Justfile=1;4;33:*Procfile=1;4;33:*Dockerfile=1;4;33:*Containerfile=1;4;33:*Vagrantfile=1;4;33:*Brewfile=1;4;33:*Gemfile=1;4;33:*Pipfile=1;4;33:*build.sbt=1;4;33:*mix.exs=1;4;33:*bsconfig.json=1;4;33:*tsconfig.json=1;4;33:*.zip=0;31:*.tar=0;31:*.Z=0;31:*.z=0;31:*.gz=0;31:*.bz2=0;31:*.a=0;31:*.ar=0;31:*.7z=0;31:*.iso=0;31:*.dmg=0;31:*.tc=0;31:*.rar=0;31:*.par=0;31:*.tgz=0;31:*.xz=0;31:*.txz=0;31:*.lz=0;31:*.tlz=0;31:*.lzma=0;31:*.deb=0;31:*.rpm=0;31:*.zst=0;31:*.lz4=0;31" && export LS_COLORS

# Colors for eza
EZA_COLORS="uu=37:gu=37:un=1;37:gn=1;37:da=37" && export EZA_COLORS

# Make cd use the ls colours
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
autoload -Uz compinit
compinit

########################## ALIASES ##########################

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

################ MISC ################

# zsh smart mv 
autoload -U zmv

# alt-tab for quoted completion
autoload -Uz quote-and-complete-word
zle -N quote-and-complete-word
bindkey '^[[Z' quote-and-complete-word

################ P10K ################

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

