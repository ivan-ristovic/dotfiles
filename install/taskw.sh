#!/bin/bash

source "utils.sh"

inst $@ task timew taskwarrior-tui
pip install tasklib
