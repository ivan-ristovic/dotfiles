#!/bin/bash

source "$SHLIB_ROOT/std.sh"

function time::now ()
{
    date +%s
}

function date::now ()
{
    date --iso
}


