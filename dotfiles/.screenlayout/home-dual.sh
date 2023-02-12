#!/bin/sh
xrandr --output eDP-1 --mode 1920x1080 --rate 60.02 --pos 1920x0 --rotate normal --output DP-1-0 --off --output DP-1-1 --off --output HDMI-1-0 --primary --mode 1920x1080 --rate 144.01 --pos 0x0 --rotate normal --output DP-1-2 --off --output DP-1-3 --off
feh --bg-fill ~/.config/i3/wp.png
