#!/bin/bash

function o ()
{
	if [ $# -eq 0 ]; then
		$FILEMGR .;
	else
		xdg-open "$@";
	fi;
}

function mkd ()
{
    mkdir -p "$@" && cd "$_";
}

function fs ()
{
    if du -b /dev/null >/dev/null 2>&1; then
        local arg=-sbh
    else
        local arg=-sh
    fi
    if [[ -n $@ ]]; then
        du $arg -- "$@"
    else
        du $arg .[^.]* ./*
    fi
}