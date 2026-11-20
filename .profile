source .bashrc
[ "$(tty)" == "/dev/tty1" ] && exec niri-session -l 2>/dev/null
