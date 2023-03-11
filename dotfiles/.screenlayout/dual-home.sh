#!/bin/sh

if glxinfo | grep "OpenGL vendor string" | grep NVIDIA ; then
    xrandr --output eDP-1-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1-0 --off --output DP-1-1 --off --output HDMI-1-0 --off --output DP-1-2 --off --output DP-1-3 --off
else 
    xrandr --output DP-0 --off --output DP-1 --off --output HDMI-0 --primary --mode 1920x1080 --rate 144.01 --pos 0x0 --rotate normal --output DP-2 --off --output DP-3 --off --output eDP-1-1 --mode 1920x1080 --pos 1920x0 --rotate normal
fi

feh --bg-fill ~/.config/i3/wp.png
