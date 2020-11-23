#!/bin/bash

source utils.sh

msg "Downloading youtube-dl ..."
sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl

inst $@ ffmpeg

