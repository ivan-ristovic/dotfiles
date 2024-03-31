#!/bin/bash

source "$SHLIB_ROOT/std.sh"

function io::is_dir ()
{
    std::is_all -d "$@"
}

function io::is_dev ()
{
    std::is_all -b "$@"
}

function io::is_file ()
{
    std::is_all -f "$@"
}

