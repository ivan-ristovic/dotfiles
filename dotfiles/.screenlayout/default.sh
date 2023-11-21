#!/bin/sh

if glxinfo | grep "OpenGL vendor string" | grep NVIDIA ; then
    xrandr --output eDP-1-1 --primary --mode 1920x1200 --pos 0x0 --rotate normal --output DP-1-0 --off --output DP-1-1 --off --output HDMI-1-0 --off --output DP-1-2 --off --output DP-1-3 --off
else 
    xrandr --output eDP-1 --primary --mode 1920x1200 --pos 0x0 --rotate normal --output DP-1-0 --off --output DP-1-1 --off --output HDMI-1-0 --off --output DP-1-2 --off --output DP-1-3 --off
fi

feh --bg-fill ~/.config/i3/wp.png
