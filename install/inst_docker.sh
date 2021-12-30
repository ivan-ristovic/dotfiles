#!/bin/bash

source "utils.sh"

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh

sudo groupadd docker
sudo usermod -aG docker $SETUP_USER
newgrp docker

sudo systemctl enable docker.service
sudo systemctl enable containerd.service

sudo curl -L "https://github.com/docker/compose/releases/download/v2.22/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

