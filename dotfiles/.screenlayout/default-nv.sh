#!/bin/sh
xrandr --output DP-0 --off --output DP-1 --off --output HDMI-0 --primary --mode 1920x1080 --rate 144.01 --pos 0x0 --rotate normal --output DP-2 --off --output DP-3 --off --output eDP-1-1 --off
feh --bg-fill ~/.config/i3/wp.png