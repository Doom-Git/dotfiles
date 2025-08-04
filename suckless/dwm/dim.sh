#!/bin/sh

dpy=$(xdpyinfo | rg dimensions | rg 1080)

if [ -z "$dpy" ]; then
  maim -g 2560x1440+1920+0 ~/media/pictures/screenshots/$(date +%Y-%m-%d_%H:%M:%S).png
else
  maim -g 1920x1080 ~/media/pictures/screenshots/$(date +%Y-%m-%d_%H:%M:%S).png
fi
