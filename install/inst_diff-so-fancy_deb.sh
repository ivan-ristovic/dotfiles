#!/bin/bash

source "utils.sh"

sudo add-apt-repository ppa:aos1/diff-so-fancy
sudo apt update

inst $@ diff-so-fancy

