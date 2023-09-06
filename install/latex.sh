#!/bin/bash

source "utils.sh"

pkgs=(
    texlive-latexextra 
    texlive-langextra 
    texlive-langcyrillic 
    texlive-fontsextra 
    texlive-bibtexextra
    texlive-science
)

inst $@ "${pkgs[@]}" 

msg "Compiling cyrillic fonts..."
if mktextfm larm1000 > /dev/null 2>&1 ; then
    suc "Successfully compiled cyrillic fonts"
else
    err "Failed to compile cyrillic fonts"
    err "Make sure to run mktextfm again manually"
fi

