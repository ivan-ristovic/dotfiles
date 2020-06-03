#!/bin/bash

source "utils.sh"

msg "Updating..."

apt-get update
apt-get dist-upgrade
