#!/bin/bash

source "utils.sh"

inst $@ git

msg "Changing git credentials and cache"
git config --global user.email "ivan.ristovic95@gmail.com"
git config --global user.name "ivan-ristovic"
git config --global credential.helper 'cache --timeout=600'

