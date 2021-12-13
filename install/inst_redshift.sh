#!/bin/bash

source "utils.sh"

inst $@ redshift
sudo -u $SETUP_USER systemctl --user enable redshift.service

