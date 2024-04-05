#!/bin/bash

source "$SHLIB_ROOT/log.sh"

function std::usage ()
{
    std::fat "usage: $(basename "$0") $*"
}

function std::fat ()
{
    log::log "FAT" "$SHLIB_FMT_C_R" "$*"
    exit 1
}

function std::ask ()
{
    while true; do

        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -n "$1 [$prompt] "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read REPLY </dev/tty
        sleep 1

        # Default?
        if [ -z "$REPLY" ]; then
            REPLY="$default"
        fi

        # Check if the reply is valid
        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}

function std::confirm ()
{
    "$@"
    read -n 1 -s -r -p "Press any key to continue"
    echo -ne "\r"
}

function std::_beep_v () 
{
    speaker-test -Dpulse -f $1 --test sine -l 1 & sleep $2 && kill -9 $!
}

function std::beep ()
{
    freq="${1:-1000}"
    duration="${2:-.2}"
    std::_beep_v $freq $duration > /dev/null 2>&1
}


function std::is_installed ()
{
    if command -v "$@" &> /dev/null ; then
        return 0
    else
        return 1
    fi
}

