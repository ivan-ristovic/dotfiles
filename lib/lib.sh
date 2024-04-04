#!/bin/bash

for __src in $SHLIB_ROOT/*.sh; do
    if [ $(basename $__src) != "lib.sh" ]; then
        source $__src
    fi
done
unset __src

