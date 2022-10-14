#!/bin/bash

source "utils.sh"

inst $@ redshift
as_user systemctl --user enable redshift.service

