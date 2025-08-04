# config.nu
#
# Installed by:
# version = "0.104.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
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

$env.config.show_banner = false


source ./catppuccin_mocha.nu

# Aliases
alias d = devour
alias la = ls -la
alias install = sudo xbps-install -Suy
alias ff = fastfetch --config ~/.config/fastfetch/config.jsonc
alias shut = sudo shutdown -f -h now
alias mi = sudo make install
alias nc = ncmpcpp
alias v = nvim
alias sol = wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
alias soh = wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
alias mpcp = mpc -p 6492
alias locate = sudo xbps-query -f
alias loadp = mpc -p 6492 load Standart
alias ac = ani-cli
alias img = d st -e feh -F


def dsize [...dir] {
  let entries = la ($dir | str join)
  mut total = 0

  for entry in $entries {
    if ($entry.type == "file") {
      $total += ($entry.size | into int)
    } else if ($entry.type == "dir") {
      let subtotal = dsize $entry.name
      $total += $subtotal
    }
  }

  return $total
}

# Exports
# export-env XDG_RUNTIME_DIR=/run/user/$(id -u)


# Startup
clear
ff
cowsay Enter the void!
echo "\n"

