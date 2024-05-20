# Load common env
source "$HOME/.profile"

############################ MISC #############################

export HISTORY_START_WITH_GLOBAL=true

############################ PATH #############################

if [[ -d "${HOME}/dotfiles" ]]; then    
    if [[ ! -z $(grep ivan-ristovic/dotfiles "${HOME}/dotfiles/.git/config") ]]; then
        export PATH="${PATH}:${HOME}/dotfiles/bin"
    fi
fi

########################## FZF ##########################

export DISABLE_FZF_AUTO_COMPLETION=false
export DISABLE_FZF_KEY_BINDINGS=false

export FZF_DEFAULT_OPTS="--cycle --layout=reverse --info inline --border --preview 'preview {} || '" 
export FORGIT_FZF_DEFAULT_OPTS="--cycle --layout=reverse ${FORGIT_FZF_DEFAULT_OPTS}"
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

