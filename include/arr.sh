#!/bin/bash

function arr::print () 
{
    eval "printf '%s\n' \"\${$1[@]}\""
}

function arr::append ()
{
    local array=$1; shift 1
    local len

    eval "$(arr::__size len "$array")"

    if (( len == 0 )); then
        eval "$(arr::__append_first "$array" "$1")"
        shift 1
    fi

    local i
    for i in "$@"; do
        eval "$(arr::__append "$array" "$i")"
    done
}

function arr::size ()
{
    local size
    eval "$(arr::__size size "$1")"
    echo "$size"
}

function arr::__size () 
{
    echo -n 'eval local '
    echo -n "$1" # variable name
    echo -n '=${#'
    echo -n "$2" # array name
    echo -n '[@]}'
}

function arr::__append () 
{
    echo -n 'eval '
    echo -n "$1" # array name
    echo -n '=( "${'
    echo -n "$1"
    echo -n '[@]}" "'
    echo -n "$2" # item to append
    echo -n '" )'
}

function arr::__append_first () 
{
    echo -n 'eval '
    echo -n "$1" # array name
    echo -n '=( '
    echo -n "$2" # item to append
    echo -n ' )'
}

function arr::reverse ()
{
    shopt -s extdebug
    f()(printf '%s\n' "${BASH_ARGV[@]}"); f "$@"
    shopt -u extdebug
}

function arr::uniq ()
{
    declare -A tmp_array

    for i in "$@"; do
        [[ $i ]] && IFS=" " tmp_array["${i:- }"]=1
    done

    printf '%s\n' "${!tmp_array[@]}"
}

function arr::rand_elem ()
{
    local arr=("$@")
    printf '%s\n' "${arr[RANDOM % $#]}"
}

