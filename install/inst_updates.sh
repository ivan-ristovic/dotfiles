#!/bin/bash

source "utils.sh"

msg "Updating..."

apt-get update > /dev/null
apt-get dist-upgrade > /dev/null