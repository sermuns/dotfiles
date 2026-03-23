yt-album() {
	yt-dlp "$@" --no-warnings --split-chapters -x -o "chapter:~/Music/%(title)s/[%(section_number)02d] %(section_title)s.%(ext)s" --exec rm
}

yt-playlist() {
	yt-dlp "$@" -N 4 --no-warnings -x --audio-format opus -o "~/Music/%(playlist)s/[%(playlist_index)s] %(title)s.%(ext)s"
}

ly() {
	lazygit -ucd ~/.local/share/yadm/lazygit -w ~ -g ~/.local/share/yadm/repo.git
}

flash() {
	local input_file="$1"
	local output_device="$2"
	sudo pv $input_file -Yo $output_device
}

centercrop() {
	if [ $# -lt 2 ]; then
		echo "Usage: centercrop <input> <output>"
		return 1
	fi
	magick $1 -gravity center -crop "%[fx:min(w,h)]x%[fx:min(w,h)]+0+0" +repage $2
}

monbr () {
	ddcutil setvcp 10 $1
}

fastfetch() {
    command fastfetch --logo "$(command fastfetch --list-logos | awk -F'"' '{gsub(/[0-9()]/,"",$2); if($2!="") print $2}' | shuf -n1)" "$@"
}

opout() {
	ffmpeg -i file:$1 -c copy file:${1%.*}.opus
}

function b() {
	printf "%s %%" $(< /sys/class/power_supply/BAT0/capacity) | figlet
}

function t() {
	date +'%H : %M' | figlet
}

function ntfy() {
	curl -d "$1" $NTFY
}
