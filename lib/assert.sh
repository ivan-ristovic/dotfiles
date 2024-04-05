#!/bin/bash

source "$SHLIB_ROOT/std.sh"

function assert::argc ()
{
    local actual=$1
    local expected=$2
    shift 2
    if [ "$expected" -ne "$actual" ]; then
        if [ $# -gt 0 ]; then
            std::usage "$*"
        else
            std::usage "expected $expected arguments, got $actual"
        fi
    fi
}

function assert::pwd ()
{
    local found=false
    for dir in $@ ; do
        if [ "${PWD##*/}" == "$dir" ] ; then
            found=true
        fi
    done

    if ! $found ; then
        std::fat "must be in any of following dirs: $*"
    fi
}

function test::var_defined () 
{
    [[ "${!1-X}" == "${!1-Y}" ]]
}

function assert::var_defined ()
{
    if ! test::var_defined "$1" ; then
        std::fat "$1 not defined"
    fi
}

function test::var_set () 
{
    test::var_defined "$1" && [[ -n ${!1} ]]
}

function assert::var_set ()
{
    if ! test::var_set "$1" ; then
        std::fat "$1 not set"
    fi
}

function test::fn_defined () 
{ 
    declare -f "$1" >/dev/null
}

function assert::fn_defined ()
{
    if ! test::fn_defined "$1" ; then
        std::fat "function $1 not defined"
    fi
}

function test::all ()
{
    args="$1"
    shift 1
    for f in "$@"; do
        if ! test "$args" "$f"; then
            return 1
        fi
    done
}

function test::any ()
{
    args="$1"
    shift 1
    for f in "$@"; do
        if test "$args" "$f"; then
            return 0
        fi
    done
    return 1
}

function assert::pass ()
{
    if ! "$@" ; then
        std::fat "assertion failed: $*"
    fi
}

function assert::that ()
{
    local msg="$1"
    shift 1
    if ! "$@" ; then
        std::fat "assertion failed: $msg"
    fi
}


