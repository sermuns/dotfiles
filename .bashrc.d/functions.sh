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

mkfat() {
	if [ "$#" -ne 1 ]; then
		echo "Usage: mkfat <device>"
		return 1
	fi

	local device="$1"

	lsblk $device
	read -p "Are you sure you want to format $device as FAT32? This will erase all data on the device. (y/n): " confirm
	if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
		echo "Operation cancelled."
		return 1
	fi

	sudo wipefs -a $device || return 1
	sudo parted $device --script mklabel msdos || return 1
	sudo parted $device --script mkpart primary fat32 0% 100% || return 1
	sudo mkfs.vfat -F 32 ${device}1 || return 1
}

mkntfs() {
	if [ "$#" -ne 1 ]; then
		echo "Usage: mkntfs <device>"
		return 1
	fi

	local device="$1"

	lsblk "$device"
	read -p "Are you sure you want to format $device as NTFS? This will erase all data on the device. (y/n): " confirm
	if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
		echo "Operation cancelled."
		return 1
	fi

	sudo wipefs -a "$device" || return 1
	sudo parted "$device" --script mklabel msdos || return 1
	sudo parted "$device" --script mkpart primary ntfs 0% 100% || return 1

	local part="${device}1"
	[[ "$device" =~ mmcblk[0-9]$ || "$device" =~ nvme[0-9]n[0-9]$ ]] && part="${device}p1"

	sudo mkfs.ntfs -f "$part" || return 1
}

png2ico() {
	local i="${1}" o="${2:-${1:r}.ico}" s="${png2ico_size:-256}"
	convert -resize x${s} -gravity center -crop ${s}x${s}+0+0 "$i" -flatten -colors 256 -background transparent "$o"
}

vaapi_encode() {
    if [ $# -lt 2 ]; then
        echo "Usage: vaapi_encode <input.mp4> <output.mp4> [qp]"
        return 1
    fi
    local input="$1"
    local output="$2"
    local qp="${3:-30}" # default QP if not provided

    ffmpeg -hwaccel vaapi -vaapi_device /dev/dri/renderD129 \
        -i "$input" \
        -vf 'format=nv12,hwupload' \
        -c:v h264_vaapi \
        -qp "$qp" \
        -c:a copy \
        "$output"
}

_zathura_original=$(command -v zathura)
_zathura_wrapper() {
	("$_zathura_original" "$@" &>/dev/null &)
}

alias zathura='_zathura_wrapper'

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


function paste_from_stdin() {
    local API_URL="https://bin.lysator.liu.se"
    jq -Rns '{text: inputs}' | \
        curl  -s -H 'Content-Type: application/json' --data-binary @- ${API_URL}/ | \
        jq -r '. | "'${API_URL}'\(.path)"'
}

function b() {
	printf "%s %%" $(< /sys/class/power_supply/BAT0/capacity) | figlet
}
