#!/bin/bash

source "utils.sh"

inst $@ \
    retroarch \
    retroarch-assets-ozone \
    libretro-mame \
    libretro-mesen \
    libretro-nestopia \
    libretro-picodrive

inst_aur libretro-fbneo
