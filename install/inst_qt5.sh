#!/bin/bash

source "utils.sh"

inst $@ qt5-default
inst $@ qtcreator
inst $@ qt5-doc qt5-doc-html qtbase5-doc-html
msg "Executing ldconfig ..."
/sbin/ldconfig -v > /dev/null
