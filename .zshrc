# The following lines were added by compinstall
zstyle :compinstall filename '/home/mario/.zshrc'

autoload -Uz compinit
autoload -U colors && colors
compinit
# End of lines added by compinstall

# Exports
export EDITOR="$HOME/nvim-linux-x86_64/bin/nvim"
export PASTEL_COLOR_MODE="24bit"
export JAVA_HOME="/usr/lib/jvm/openjdk21/"

autoload -U colors && colors
user_color="%F{142}"     # green (bright)
host_color="%F{109}"     # blue-ish
path_color="%F{214}"     # yellow-orange
bracket_color="%F{167}"  # red
reset_color="%f"

PS1="%B${bracket_color}["\
"${user_color}%n"\
"${host_color}@%M "\
"${path_color}%c"\
"${bracket_color}]${reset_color}$ %b"

# Opts and settings
setopt autocd
setopt correct
setopt auto_param_slash # when a dir is completed, add a / instead of a trailing space
setopt globdots # include dotfiles
setopt extended_glob # match ~ # ^
setopt interactive_comments # allow comments in shell
unsetopt prompt_sp # don't autoclean blanklines
stty stop undef # disable accidental ctrl s


HISTSIZE=100000

# Bat aliases
alias man="$HOME/.config/scripts/bat-extras/src/batman.sh"
alias bd="$HOME/.config/scripts/bat-extras/src/batdiff.sh"
alias cat="bat"

alias fzf="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
alias qp="xbps-query -Rs"
alias ns="notify-send"
alias d=devour
alias ls="eza -lG"
alias la="eza -laG"
alias install="sudo xbps-install -Suy"
alias remove="sudo xbps-remove -R"
alias ff="fastfetch --pipe false --config ~/.config/fastfetch/config.jsonc"
alias shut="sudo shutdown -f -h now"
alias mi="sudo make install"
alias v="$HOME/nvim-linux-x86_64/bin/nvim"
alias sol="wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
alias soh="wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
alias mpc="mpc -p 6492"
alias mpl="mpc -p 6492 load Standart"
alias mpu="mpc -p 6492 update"
alias ac=ani-cli
alias tmu="tmux attach || tmux"
alias kp="keepassxc-cli"
alias sz="source $HOME/.zshrc"
alias zat="d zathura"
alias tc="typst compile"
alias tw="typst watch"
alias rm="rm -rvf"
alias fehbg="feh --no-fehbg --bg-fill --randomize ~/media/pictures/wallpaper/2560x1440/*"
alias pc="peaclock --config-dir=$HOME/.config/peaclock/"

fn() { fzf -m --preview='bat --color=always {}' --bind 'enter:become($HOME/nvim-linux-x86_64/bin/nvim {+})'; }

fv() {
  fd --type f -e avi -e mp4 -e wmv -e dat -e 3gp -e ogv -e mkv -e mpg -e mpeg -e vob \
			 -e fli -e flc -e flv -e m2v -e mov -e webm -e mts -e m4v -e ram -e qt -e divx \
			 -e asf -e asx . |
  fzf -m \
		--preview='ffmpeg -y -loglevel quiet -ss 00:00:02 -i {} -vframes 1 /tmp/preview.png &&
		chafa /tmp/preview.png' \
		--preview-window=down:99% \
		--bind 'enter:become(mpv {+})'
}

fa() { 
	fd . -e wav -e mp3 -e flac -e m4a -e wma -e ape -e ac3 -e oga -e ogg \
			 -e ogx -e spx -e opus -e aac -e mpga |
	fzf -m --preview='' --bind 'enter:become(mpv --no-video {+})';
}

fp() { 
	fd . -e pdf |
	fzf --preview='' --bind 'enter:become(devour zathura {+})';
}

fim() {
  fd . -e jpg -e jpeg -e png -e gif -e webp -e bmp -e xpm -i |
    fzf	--layout=reverse \
    		--border \
        --bind 'enter:become(devour nsxiv -t {+})'
}


# Startup
ani-cli -U
clear
ff 
cowsay Enter the void!
source ~/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
echo
