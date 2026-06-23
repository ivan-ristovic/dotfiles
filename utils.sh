#!/bin/bash

if [ "$DOTFILES_UTILS_SOURCED" == true ]; then
    return
fi

export SHLIB_FMT_TIME=true

if [ -n "$SHLIB_ROOT" ] && [ -f "$SHLIB_ROOT/lib.sh" ]; then
    # shellcheck source=/dev/null
    source "$SHLIB_ROOT/lib.sh"
else
    function __log ()
    {
        local level=$1
        shift
        printf '[%s] %s\n' "$level" "$*"
    }

    function log_msg () { __log "INFO" "$@"; }
    function log_suc () { __log " OK " "$@"; }
    function log_wrn () { __log "WARN" "$@"; }
    function log_err () { __log "ERR " "$@" >&2; }
    function log_dbg () { [ -n "$DEBUG" ] && __log "DBG " "$@"; }
    function log_exec () { log_msg "$*"; "$@"; }
    function std_err () { log_err "$@"; }
    function std_fat () { log_err "$@"; exit 1; }
    function std_ask ()
    {
        local answer
        read -r -p "$* [y/N] " answer
        [[ "$answer" == [Yy]* ]]
    }
    function std_confirm () { "$@"; }
    function test_installed () { command -v "$1" > /dev/null 2>&1; }
    function assert_argc_ge ()
    {
        local actual=$1
        local expected=$2
        local usage=$3
        [ "$actual" -ge "$expected" ] || std_fat "usage: $usage"
    }
    function io_is_file () { [ -f "$1" ]; }
    function os_path_par () { dirname -- "$1"; }
    function os_path_abs ()
    {
        local dir
        local base
        dir=$(dirname -- "$1") || return
        base=$(basename -- "$1") || return
        printf '%s/%s\n' "$(cd "$dir" && pwd -P)" "$base"
    }
    function str_join ()
    {
        local sep=$1
        shift
        local first=true
        local item
        for item in "$@"; do
            if $first; then
                first=false
            else
                printf '%s' "$sep"
            fi
            printf '%s' "$item"
        done
        printf '\n'
    }
fi

function uninst ()
{
    if [ "${#PM_UNINSTALL_CMD[@]}" -eq 0 ]; then
        log_err "No package uninstall command configured"
        return 1
    fi
    if ! sudo "${PM_UNINSTALL_CMD[@]}" "$@"; then
        log_wrn "An error occurred while uninstalling: $*"
        return 1
    fi
}

function inst ()
{
    if ! inst_silent "$@"; then
        log_err "An error occurred while installing: $*"
        return 1
    fi
}

function inst_silent ()
{
    if [ "${#PM_INSTALL_CMD[@]}" -eq 0 ]; then
        log_err "No package install command configured"
        return 1
    fi
    if is_android ; then
        "${PM_INSTALL_CMD[@]}" "$@"
    else
        sudo "${PM_INSTALL_CMD[@]}" "$@"
    fi
}

function inst_aur ()
{
    if ! yay -S --sudoloop --needed --noconfirm --provides=false --answerdiff None --answerclean None --mflags "--noconfirm --needed" "$@"; then
        log_err "An error occurred while installing from AUR: $*"
        return 1
    fi
}

function inst_pip ()
{
    if [ -f /etc/arch-release ]; then
        local args=("$@")
        inst "${args[@]/#/python-}"
        unset args
    else
        pip install "$@"
    fi
}

function ensure_user_owned_dir ()
{
    local dir=$1

    sudo mkdir -p "$dir"
    sudo chown "$SETUP_USER":"$SETUP_USER" "$dir"
}

function _git_clone_or_pull ()
{
    local runner=$1
    local repo_url=$2
    local target_dir=$3
    local parent_dir
    local -a command_prefix=()
    shift 3

    parent_dir=$(dirname -- "$target_dir") || return
    if [ -n "$runner" ]; then
        command_prefix=("$runner")
    fi

    if [ -d "$target_dir/.git" ]; then
        "${command_prefix[@]}" git -C "$target_dir" pull --ff-only
    else
        "${command_prefix[@]}" mkdir -p "$parent_dir"
        "${command_prefix[@]}" git clone "$@" "$repo_url" "$target_dir"
    fi
}

function git_clone_or_pull ()
{
    _git_clone_or_pull "" "$@"
}

function sudo_git_clone_or_pull ()
{
    _git_clone_or_pull sudo "$@"
}

function rm_comments ()
{
    sed -e 's/[[:space:]]*#.*// ; /^[[:space:]]*$/d' "$@"
}

function read_list ()
{
    rm_comments "$1" | tr '[:space:]' '\n' | sed '/^$/d'
}

function is_android () 
{
    if [ "$OSTYPE" == "linux-android" ]; then
        return 0
    else
        return 1
    fi
}

function setup_pm_cmds ()
{
    if is_android ; then
        PM_INSTALL_CMD=(pkg install)
        PM_UNINSTALL_CMD=(pkg uninstall)
        return
    fi

    if [ -f /etc/redhat-release ]; then
        PM_INSTALL_CMD=(yum -y install)
        PM_UNINSTALL_CMD=(yum -y remove)
    elif [ -f /etc/arch-release ]; then
        PM_INSTALL_CMD=(pacman --noconfirm --needed -S)
        PM_UNINSTALL_CMD=(pacman --noconfirm -R)
    elif [ -f /etc/gentoo-release ]; then
        PM_INSTALL_CMD=(emerge)
        PM_UNINSTALL_CMD=(emerge --deselect)
    elif [ -f /etc/SuSE-release ]; then
        PM_INSTALL_CMD=(zypper install)
        PM_UNINSTALL_CMD=(zypper remove)
    elif [ -f /etc/debian_version ]; then
        PM_INSTALL_CMD=(apt-get install -qq)
        PM_UNINSTALL_CMD=(apt-get remove -qq)
    else
        PM_INSTALL_CMD=()
        PM_UNINSTALL_CMD=()
        log_err "cannot detect package manager"
    fi
}

setup_pm_cmds

export DOTFILES_UTILS_SOURCED=true
