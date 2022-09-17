#!/bin/bash

source "utils.sh"

inst_aur $@ g810-led-git 
sudo mv /etc/g810-led/samples/all_green /etc/g810-led/profile

