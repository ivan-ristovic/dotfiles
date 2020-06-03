#!/bin/bash

source "utils.sh"

msg "Updating..."

sudo apt-get -y update
sudo apt-get -y dist-upgrade
