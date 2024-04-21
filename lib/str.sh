#!/bin/bash

function str::len ()
{
    printf "%s\\n" "${#1}"
}

function str::format ()
{
    # Format a string.
    #
    # usage:
    #   str_format format_string input [output_var|-]
    
    declare _format="$1" _input="$2" _return="$3"

    # shellcheck disable=SC2059
    if [[ -n "${_return}" && "${_return}" != "-" ]]; then
        printf -v "${_return}" "${_format}" "${_input}"
    else
        printf "${_format}" "${_input}"
    fi
}

function str::join () 
{
    local d=${1-} f=${2-}
    if shift 2; then
        printf %s "$f" "${@/#/$d}"
    fi
} 

function str::replace ()
{
    local str="$1"
    local pattern="$2"
    local replacement="$3"
    echo "${str//"$pattern"/"$replacement"}"
}

function str::trim ()
{
    : "${1#"${1%%[![:space:]]*}"}"
    : "${_%"${_##*[![:space:]]}"}"
    printf '%s\n' "$_"
}

function str::strip_a ()
{
    pattern=$1
    shift
    printf '%s\n' "${@//$pattern}"
}

function str::strip_f ()
{
    pattern=$1
    shift
    printf '%s\n' "${@/$pattern}"
}

function str::strip_l ()
{
    pattern=$1
    shift
    printf '%s\n' "${@##"$pattern"}"
}

function str::strip_r ()
{
    pattern=$1
    shift
    printf '%s\n' "${@%%"$pattern"}"
}

function str::split ()
{
    delim=$1
    shift
    IFS=$'\n' read -d "" -r arr <<< "${@//"$delim"/$'\n'}"
    printf '%s\n' "${arr[@]}"
}

function str::url_encode ()
{
    local LC_ALL=C
    for (( i = 0; i < ${#1}; i++ )); do
        : "${1:i:1}"
        case "$_" in
            [a-zA-Z0-9:/.~_-])
                printf '%s' "$_"
            ;;

            *)
                printf '%%%02X' "'$_"
            ;;
        esac
    done
    printf '\n'
}

function str::url_decode ()
{
    : "${1//+/ }"
    printf '%b\n' "${_//%/\\x}"
}

function str::to_lower ()
{
    printf '%s\n' "${1,,}"
}

function str::to_upper () 
{
    printf '%s\n' "${1^^}"
}

function str::contains ()
{
    needle=$1
    shift
    [[ "$*" == *"$needle"* ]]
}

function str::starts_with ()
{
    needle=$1
    shift
    [[ "$*" == "$needle"* ]]
}

function str::ends_with ()
{
    needle=$1
    shift
    [[ "$*" == *"$needle" ]]
}

function str::is_match ()
{
    # shellcheck disable=SC2053
    if [[ "$1" != $2 ]] ; then
        return 0
    else
        return 1
    fi
}

function str::is_digit ()
{
    str::is_match "$1" "*[!0-9]*"
}

function str::is_alpha ()
{
    str::is_match "$1" "*[!a-zA-Z]*"
}

function str::is_alnum ()
{
    str::is_match "$1" "*[!0-9a-zA-Z]*"
}
