#!/bin/bash

source "$SHLIB_ROOT/fmt.sh"

function std::usage ()
{
    std:fat "usage: $*"
}

function std::fat ()
{
    fmt::err "$*"
    exit 1
}

function std::assert_argc ()
{
    local expected=$1
    local actual=$2
    if [ "$expected" -ne "$actual" ]; then
        std::usage "$0: expected $expected arguments, got $actual"
    fi
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

function std::is_d ()
{
    std::is_all -d "$@"
}

function std::is_f ()
{
    std::is_all -f "$@"
}

function std::is_all ()
{
    args="$1"
    shift 1
    for f in "$@"; do
        if ! test "$args" "$f"; then
            return 1
        fi
    done
}

function std::is_installed ()
{
    if command -v "$@" &> /dev/null ; then
        return 0
    else
        return 1
    fi
}

