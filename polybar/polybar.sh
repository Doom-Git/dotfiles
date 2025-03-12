#!/usr/bin/env sh

# Kill all processes of polybar
polybar-msg cmd quit

# Launch polybar
polybar voidbar &

# Find all monitors
if type "xrandr"; then
  for m in $(xrandr --query | grep -w connected | cut -d" " -f1 | tac); do
    MONITOR=$m polybar --reload voidbar &
  done
else
  polybar --reload voidbar &
fi


