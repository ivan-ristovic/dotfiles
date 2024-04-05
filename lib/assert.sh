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

function assert::argc_ge ()
{
    local actual=$1
    local expected=$2
    shift 2
    if [ "$expected" -lt "$actual" ]; then
        if [ $# -gt 0 ]; then
            std::usage "$*"
        else
            std::usage "expected $expected arguments, got $actual"
        fi
    fi
}

function assert::args ()
{
    if [ $1 -eq 0 ]; then
        shift
        std::usage "$*"
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

    assert::that "current dir must be any of: $*" $found
}

function test::var_defined () 
{
    [[ "${!1-X}" == "${!1-Y}" ]]
}

function assert::var_defined ()
{
    assert::that "var defined: $1" test::var_defined "$1"
}

function test::var_set () 
{
    test::var_defined "$1" && [[ -n ${!1} ]]
}

function assert::var_set ()
{
    assert::that "var set: $1" test::var_set "$1"
}

function test::fn_defined () 
{ 
    declare -f "$1" >/dev/null
}

function assert::fn_defined ()
{
    assert::that "function defined: $1" test::fn_defined "$1"
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

function test::installed ()
{
    if command -v "$@" &> /dev/null ; then
        return 0
    else
        return 1
    fi
}

function assert::installed ()
{
    assert::that test::installed "command not found: $*" "$@"
}

