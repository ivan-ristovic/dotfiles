#!/bin/bash

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

