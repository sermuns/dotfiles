export PATH="$PATH:$HOME/.cargo/bin:$HOME/.local/bin"
[ $(tty) == "/dev/tty1" ] && exec niri-session -l 2>/dev/null
