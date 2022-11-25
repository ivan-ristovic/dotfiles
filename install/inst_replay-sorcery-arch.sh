#!/bin/bash

source "utils.sh"

inst_aur $@ replay-sorcery-git

as_user systemctl --user enable replay-sorcery
as_user systemctl --user enable replay-sorcery-kms
