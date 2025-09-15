#!/bin/sh
exec xrandr --output eDP-1 --off &
exec xrandr --output HDMI-2 --primary &
exec feh --no-fehbg --bg-fill --randomize ~/media/pictures/wallpaper/2560x1440/* &
notify-send "Mulmon" "Multimonitor setup complete"
