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
  tmuxinator                # tmuxinator completion and aliases
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

############################ MISC #############################

source ~/.env

export HISTORY_START_WITH_GLOBAL=true

############################ PATH #############################

if [[ -d "${HOME}/dotfiles" ]]; then    
    if [[ ! -z $(grep ivan-ristovic/dotfiles "${HOME}/dotfiles/.git/config") ]]; then
        export PATH="${PATH}:${HOME}/dotfiles/bin"
    fi
fi

########################## LS COLORS ##########################

LS_COLORS="ow=01;36;40" && export LS_COLORS

# Make cd use the ls colours
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
autoload -Uz compinit
compinit

########################## FZF ##########################

export DISABLE_FZF_AUTO_COMPLETION=false
export DISABLE_FZF_KEY_BINDINGS=false

# FIXME Find a better preview option
export FZF_DEFAULT_OPTS="--layout=reverse --info inline --border --preview 'bat --style=numbers --color=always --line-range :500 {} || '" 

export FORGIT_FZF_DEFAULT_OPTS="--layout=reverse ${FORGIT_FZF_DEFAULT_OPTS}"
#export FORGIT_FZF_DEFAULT_OPTS="--exact --cycle --height '80%'"

# Use ~~ as the trigger sequence instead of the default **
#export FZF_COMPLETION_TRIGGER='~~'

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# (EXPERIMENTAL) Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    *)            fzf "$@" ;;
  esac
}

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

################ AUTOLOAD ################

autoload -U zmv

################ P10K ################

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

