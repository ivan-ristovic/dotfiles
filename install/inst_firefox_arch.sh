#!/bin/bash

source "utils.sh"

inst $@ firefox
xdg-settings set default-web-browser firefox.desktop

