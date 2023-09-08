#!/bin/bash

source ../install/utils.sh

function process_patch () 
{
    patch=$1
    target_file=$(head -n 1 $patch) 
    target_contents=$(tail -n +3 $patch)
    echo "$target_contents" >> $target_file
}

function swap_file ()
{
    patch=$1
    target_file=$(head -n 1 $patch) 
    target_contents=$(tail -n +3 $patch)
    echo "$target_contents" > $target_file
}

for patch in *.patch ; do
    patched="$patch.patched"
    if [[ -f $patched ]]; then
        msg "Skipping already performed patch: $patch"
    else
        msg "Performing patch: $patch"
        process_patch $patch
        if [[ $? -eq 0 ]]; then
            as_user touch $patched
        else
            err "Patch failed: $patch"
        fi
    fi
done

for swap in *.swap ; do
    msg "Performing swap: $swap"
    swap_file $swap
    if [[ $? -ne 0 ]]; then
        err "Swap failed: $swap"
    fi
done

