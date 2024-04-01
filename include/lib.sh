#!/bin/bash

for src in $SHLIB_ROOT/*.sh; do
    if [ $(basename $src) != "lib.sh" ]; then
        source $src
    fi
done
unset src

