#!/bin/bash

function str::join () 
{
    local d=${1-} f=${2-}
    if shift 2; then
        printf %s "$f" "${@/#/$d}"
    fi
} 

function str::trim ()
{
    echo "$*" | sed 's/^ *//; s/ *$//; /^$/d' 
}

function str::split ()
{
    delim=$1
    shift
    spl=(${*//"$delim"/ })
    for s in "${spl[@]}"; do
        echo "$s"
    done
}

function str::to_lower ()
{
    tr '[:upper:]' '[:lower:]' <<< "$@"
}

function str::to_upper () 
{
    tr '[:lower:]' '[:upper:]' <<< "$@"
}

