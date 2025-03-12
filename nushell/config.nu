# config.nu
#
# Installed by:
# version = "0.101.0"
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

$env.config.buffer_editor = "nvim"
$env.config.show_banner = false
alias ff = fastfetch 

# Startup
ani-cli -U
clear
ff
cowsay Enter the VOID!


# Aliases
alias pi3 = pipes.sh -t 3
alias pi = pipes.sh

alias la = ls -la
alias shutdown = sudo shutdown -h now

alias confi3 = nvim ~/.config/i3/config
alias confpoly = nvim ~/.config/polybar/config.ini

alias kmap = setxkbmap -layout de
alias wimg = wezterm imgcat --no-preserve-aspect-ratio
