#!/bin/bash

function os::path::abs ()
{
    os::path "$(realpath "$1")"
}

function os::path::file ()
{
    basename "$1"
}

function os::path::file_noext ()
{
    basename -- "$1" ".${1##*.}"
}

function os::path::ext ()
{
    filename=$(os::path::file "$1")
    echo "${filename##*.}"
}

function os::path::ext_full ()
{
    filename=$(os::path::file "$1")
    echo "${filename#*.}"
}

function os::path::par ()
{
    os::path "$(dirname "$1")"
}

function os::path ()
{
    local path=$1

    # if path has no slashes, set dir to .
    [[ $path =~ ^[^/]+$ ]] && dir=. || {
        # if path has only slashes, set dir to /
        [[ $path =~ ^/+$ ]]  && dir=/ || {              
            local IFS=/ dir_a i
            # read the components of path into an array
            read -ra dir_a <<< "$path"
            dir="${dir_a[0]}"
            # strip out any repeating slashes
            for ((i=1; i < ${#dir_a[@]}; i++)); do
                # append unless it is an empty element
                [[ ${dir_a[i]} ]] && dir="$dir/${dir_a[i]}"
            done
        }
    }

    # print only if not empty
    [[ $dir ]] && printf '%s\n' "$dir"
}

