## Built-in zsh startup profiling, make sure to uncomment the next line
## and also the line at the end of this file!
# zmodload zsh/zprof

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

######################### CONFIG #########################

ZSH_TMUX_AUTOSTART=true
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
HISTFILE=~/.zsh_history
HIST_STAMPS="yyyy-mm-dd"
HIST_SIZE=500000

setopt append_history           # allow multiple sessions to append to one history
setopt autocd                   # cd to a folder just by typing it's name
setopt bang_hist                # treat ! special during command expansion
setopt extended_history         # Write history in :start:elasped;command format
setopt hist_expire_dups_first   # expire duplicates first when trimming history
setopt hist_find_no_dups        # When searching history, don't repeat
setopt hist_ignore_dups         # ignore duplicate entries of previous events
setopt hist_ignore_space        # prefix command with a space to skip it's recording
setopt hist_reduce_blanks       # Remove extra blanks from each command added to history
setopt hist_verify              # Don't execute immediately upon history expansion
setopt inc_append_history       # Write to history file immediately, not when shell quits
setopt interactive_comments     # allow # comments in shell; good for copy/paste
setopt share_history            # Share history among all sessions
unsetopt correct_all            # I don't care for 'suggestions' from ZSH

################### ALIAS SUPPORT #####################

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

smartdots() {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
  else
    LBUFFER+=.
  fi
}
zle -N smartdots
bindkey . smartdots

####################### PLUGINS #######################

ZINIT_HOME="${HOME}/.zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Common plugins
zi light zdharma-continuum/zsh-diff-so-fancy
zi light wfxr/forgit
zi light mfaerevaag/wd

###################### VI MODE #########################

# Kept first as other plugins might override keymaps
# zi light jeffreytse/zsh-vi-mode

ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE

######################## FZF ##########################

source <(fzf --zsh)

# Git support for fzf (Ctrl+G -> key)
if [[ -r "$HOME/.fzf-git.zsh" ]]; then
    source "$HOME/.fzf-git.zsh"
fi

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

###################### FZF-TAB ########################

# Needs to be loaded after compinit, but before plugins which will wrap widgets
zi light Aloxaf/fzf-tab

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
# zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-flags --color=pointer:#5f87af,marker:#48f513 --border --cycle --info inline --multi --bind alt-backspace:toggle
zstyle ':fzf-tab:*' fzf-pad 3
zstyle ':fzf-tab:*' switch-group '<' '>'
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

################ SYNTAX HIGHLIGHTING ###################

# zi light zsh-users/zsh-syntax-highlighting
zi light zdharma-continuum/fast-syntax-highlighting

# Should reload fast-syntax-highlighting theme?
if command -v fast-theme > /dev/null 2>&1 ; then
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
fi

####################### MISC ###########################

# Smart mv 
autoload -U zmv

####################### BINDS ##########################

bindkey -e    # Emacs keys (e.g. line movements such as C-A, C-E)
# bindkey -v    # Vim mode (not needed due to vim mode plugin)

# Start typing + [Up-Arrow] - fuzzy find history forward
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search

bindkey -M emacs "^[[A" up-line-or-beginning-search
bindkey -M viins "^[[A" up-line-or-beginning-search
bindkey -M vicmd "^[[A" up-line-or-beginning-search
if [[ -n "${terminfo[kcuu1]}" ]]; then
  bindkey -M emacs "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search
fi

# Start typing + [Down-Arrow] - fuzzy find history backward
autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -M emacs "^[[B" down-line-or-beginning-search
bindkey -M viins "^[[B" down-line-or-beginning-search
bindkey -M vicmd "^[[B" down-line-or-beginning-search
if [[ -n "${terminfo[kcud1]}" ]]; then
  bindkey -M emacs "${terminfo[kcud1]}" down-line-or-beginning-search
  bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# [Home] - Go to beginning of line
if [[ -n "${terminfo[khome]}" ]]; then
  bindkey -M emacs "${terminfo[khome]}" beginning-of-line
  bindkey -M viins "${terminfo[khome]}" beginning-of-line
  bindkey -M vicmd "${terminfo[khome]}" beginning-of-line
fi
# [End] - Go to end of line
if [[ -n "${terminfo[kend]}" ]]; then
  bindkey -M emacs "${terminfo[kend]}"  end-of-line
  bindkey -M viins "${terminfo[kend]}"  end-of-line
  bindkey -M vicmd "${terminfo[kend]}"  end-of-line
fi

# [Ctrl-Delete] - delete whole forward-word
bindkey -M emacs '^[[3;5~' kill-word
bindkey -M viins '^[[3;5~' kill-word
bindkey -M vicmd '^[[3;5~' kill-word

# [Ctrl-RightArrow] - move forward one word
bindkey -M emacs '^[[1;5C' forward-word
bindkey -M viins '^[[1;5C' forward-word
bindkey -M vicmd '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey -M emacs '^[[1;5D' backward-word
bindkey -M viins '^[[1;5D' backward-word
bindkey -M vicmd '^[[1;5D' backward-word

##################### LS COLORS ########################

# Simple ls colors if not using eza
# LS_COLORS="ow=01;36;40" && export LS_COLORS

# Generated with utils/gen-ls-colors, for use with eza
LS_COLORS="di=1;34:ln=0;36:pi=0;33:bd=1;33:cd=1;33:so=1;31:ex=1;32:*README=0;4;37:*README.txt=0;4;37:*README.md=0;4;37:*readme.txt=0;4;37:*readme.md=0;4;37:*.ninja=0;33:*Makefile=0;33:*Cargo.toml=0;33:*SConstruct=0;33:*CMakeLists.txt=0;33:*build.gradle=0;33:*pom.xml=0;33:*Rakefile=0;33:*package.json=0;33:*Gruntfile.js=0;33:*Gruntfile.coffee=0;33:*BUILD=0;33:*BUILD.bazel=0;33:*WORKSPACE=0;33:*build.xml=0;33:*Podfile=0;33:*webpack.config.js=0;33:*meson.build=0;33:*composer.json=0;33:*RoboFile.php=0;33:*PKGBUILD=0;33:*Justfile=0;33:*Procfile=0;33:*Dockerfile=0;33:*Containerfile=0;33:*Vagrantfile=0;33:*Brewfile=0;33:*Gemfile=0;33:*Pipfile=0;33:*build.sbt=0;33:*mix.exs=0;33:*bsconfig.json=0;33:*tsconfig.json=0;33:*.zip=0;31:*.tar=0;31:*.Z=0;31:*.z=0;31:*.gz=0;31:*.bz2=0;31:*.a=0;31:*.ar=0;31:*.7z=0;31:*.iso=0;31:*.dmg=0;31:*.tc=0;31:*.rar=0;31:*.par=0;31:*.tgz=0;31:*.xz=0;31:*.txz=0;31:*.lz=0;31:*.tlz=0;31:*.lzma=0;31:*.deb=0;31:*.rpm=0;31:*.zst=0;31:*.lz4=0;31" && export LS_COLORS

# Colors for eza
EZA_COLORS="ur=38;5;248:uw=38;5;248:ux=38;5;210:ue=38;5;248:gr=38;5;248:gw=38;5;248:gx=38;5;210:tr=38;5;150:tw=38;5;216:tx=38;5;210:sn=37:uu=37:gu=37:un=1;37:gn=1;37:da=37" && export EZA_COLORS

# Make cd use the ls colours
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

###################  COMPLETION  #######################

fpath=(~/.config/zsh/completion $fpath)

zi light zsh-users/zsh-completions       

zi ice as"completion"
zi snippet "https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker"

# zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit
setopt complete_in_word            # cd /ho/sco/tm<TAB> expands to /home/scott/tmp
setopt auto_menu                   # show completion menu on succesive tab presses
ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;&' # These "eat" the auto prior space after a tab complete

# Load bash completion functions
autoload -U +X bashcompinit && bashcompinit

# Replay compdefs
zi cdreplay -q

# Alt-Tab for quoted completion
# `showkey -a` can be used to help find keymaps
autoload -Uz quote-and-complete-word
zle -N quote-and-complete-word
bindkey '^[\t' quote-and-complete-word

############### ALIASES  ##############

source ~/.aliases
source ~/.functions

############## COND CONF ##############

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

################ P10K #################

zi ice depth=1; 
zi light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#######################################
################ END ##################
#######################################

## Built-in zsh startup profiling, make sure to uncomment the next line
## and also the line at the top of this file!
# zprof
