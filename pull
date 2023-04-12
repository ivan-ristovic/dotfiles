#!/bin/bash

echo "Stashing existing changes..."
stash_result=$(git stash push -m "dotfiles: Before pull")
needs_pop=true
if [ "$stash_result" = "No local changes to save" ]; then
    needs_pop=false
fi

echo "Pulling updates..."
git pull

if $needs_pop; then
    echo "Restoring stashed changes..."
    git stash pop
fi

unmerged_files=$(git diff --name-only --diff-filter=U)
if [[ -n $unmerged_files ]]; then
    echo "The following files have merge conflicts after popping the stash:"
    printf %"s\n" "$unmerged_files"
else
    echo "Updating dotfiles symlinks..."
    source symlink.sh "$HOME"
fi

