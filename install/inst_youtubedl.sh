#!/bin/bash

source utils.sh

sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl

inst $@ ffmpeg

sudo wget https://raw.githubusercontent.com/hakerdefo/pmytd/master/pmytd -O /usr/local/bin/ytdl
sudo chmod a+x /usr/local/bin/ytdl

