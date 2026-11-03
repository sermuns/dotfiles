export PATH="$PATH:$HOME/.cargo/bin:$HOME/.local/bin"
[ "$(tty)" == "/dev/tty1" ] && exec niri-session -l 2>/dev/null
# >>> kache test runner >>>
[ -n "${CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_RUNNER-}" ] || CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_RUNNER='kache test-runner'; export CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_RUNNER
# <<< kache test runner <<<
# >>> kache shell completions >>>
if [[ $- == *i* && -r '/home/sermuns/.local/share/kache/completions/kache.bash' ]]; then
    . '/home/sermuns/.local/share/kache/completions/kache.bash'
fi
# <<< kache shell completions <<<
# >>> kache compiler cache >>>
case "$PATH" in
    '/home/sermuns/.local/lib/kache/shims'|'/home/sermuns/.local/lib/kache/shims':*) ;;
    *) export PATH='/home/sermuns/.local/lib/kache/shims'${PATH:+:"$PATH"} ;;
esac
# <<< kache compiler cache <<<
