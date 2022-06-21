#!/bin/bash

source "utils.sh"

inst $@ docker 

sudo usermod -aG docker $SETUP_USER
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

inst $@ docker-compose
