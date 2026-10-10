source_if_exists() {
	[ -f "$1" ] && source "$1"
}
source_if_exists /etc/bashrc
source_if_exists ~/.env

# to be able to use !(pattern-list) etc
shopt -s extglob

# eternal bash history.
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# certain bash sessions truncate .bash_history file upon close
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# write history after every command
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

export BUN_INSTALL="$HOME/.bun"
export CARGO_TARGET_DIR=$HOME/.cache/cargo
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

export EDITOR=nvim

path=(
	"$HOME/.local/bin"
	"$HOME/.cargo/bin"
	"$HOME/.cargo/binstall"
	"$BUN_INSTALL/bin"
	"$PATH"
)

export PATH=$(
	IFS=:
	echo "${path[*]}"
)

if command -v starship >/dev/null 2>&1; then
	eval "$(starship init bash)"
fi

if command -v fzf >/dev/null 2>&1; then
	eval "$(fzf --bash)"
fi

if command -v direnv >/dev/null 2>&1; then
	eval "$(direnv hook bash)"
fi

if command -v zoxide >/dev/null 2>&1; then
	eval "$(zoxide init bash --cmd cd)"
fi

alias cl='wl-copy'
alias curl='curl --progress-bar'
alias dcb='docker compose build'
alias dcd='docker compose down'
alias dcf='docker compose logs -f'
alias dcl='docker compose logs'
alias dcr='docker compose restart'
alias dcup='docker compose up -d'
alias ffmpeg='ffmpeg -hide_banner'
alias ffprobe='ffprobe -hide_banner'
alias gh='env -u GITHUB_TOKEN gh'
alias huggingface-cli='hf'
alias irc='ssh -t shipon.lysator.liu.se -- tmux -u a'
alias l='ls -hF'
alias la='ls -a'
alias lg='lazygit'
alias ls='eza --icons --hyperlink auto'
alias n='numbat'
alias open='xdg-open'
alias p='python -q'
alias pip='uv pip'
alias tree='eza --tree'
alias v=nvim
alias vim='nvim'
alias yt-dlp='yt-dlp --no-warnings'
alias zathura='zathura --fork'

yt-album() {
	yt-dlp "$@" --no-warnings --split-chapters -x -o "chapter:$HOME/Music/%(title)s/[%(section_number)02d] %(section_title)s.%(ext)s" --exec rm
}

yt-playlist() {
	yt-dlp "$@" -N 4 --no-warnings -x --audio-format opus -o "$HOME/Music/%(playlist)s/[%(playlist_index)s] %(title)s.%(ext)s"
}

ly() {
	lazygit -ucd ~/.local/share/yadm/lazygit -w ~ -g ~/.local/share/yadm/repo.git
}

flash() {
	local input_file="$1"
	local output_device="$2"
	sudo pv "$input_file" -Yo "$output_device"
}

centercrop() {
	if [ $# -lt 2 ]; then
		echo "Usage: centercrop <input> <output>"
		return 1
	fi
	magick "$1" -gravity center -crop "%[fx:min(w,h)]x%[fx:min(w,h)]+0+0" +repage "$2"
}

monbr() {
	ddcutil setvcp 10 "$1"
}

fastfetch() {
	command fastfetch --logo "$(command fastfetch --list-logos | awk -F'"' '{gsub(/[0-9()]/,"",$2); if($2!="") print $2}' | shuf -n1)" "$@"
}

opout() {
	ffmpeg -i "file:$1" -c copy "file:${1%.*}.opus"
}

function b() {
	printf "%s %%" "$(</sys/class/power_supply/BAT0/capacity)" | figlet
}

function t() {
	date +'%H : %M' | figlet
}

function ntfy() {
	curl -d "$1" "$NTFY"
}

function record-webcam() {
	if [ $# -lt 1 ]; then
		echo "Usage: record-webcam <output>, should be '.mkv'"
		return 1
	fi

	ffmpeg \
		-f v4l2 \
		-input_format mjpeg \
		-video_size 1920x1080 \
		-framerate 30 \
		-i /dev/video0 \
		-f pulse \
		-i alsa_input.usb-Microsoft_Microsoft___LifeCam_Studio_TM_-02.pro-audio0 \
		-c:v copy \
		-c:a aac -b:a 128k \
		"file:$1"
}

function duration() {
	ffprobe -v error -select_streams v:0 -show_entries stream=duration -of default=noprint_wrappers=1:nokey=1 "file:$1"
}
