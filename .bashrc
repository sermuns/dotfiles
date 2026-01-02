[ -f /etc/bashrc ] && source /etc/bashrc
[ -f ~/.env ] && source ~/.env

shopt -s extglob

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

export EDITOR=nvim
export GOPATH=~/.go
export GOBIN=~/.go/bin

export COMPOSE_BAKE=true

export CARGO_TARGET_DIR=$HOME/.cache/cargo

export PATH="$HOME/.local/bin:$HOME/bin:$GOBIN:/usr/local/go/bin:~/.cargo/bin:~/.cargo/binstall:$PATH"

if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    source "$rc"
  done
fi


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

alias fastfetch='fastfetch --sixel ~/Pictures/typst.jpg'

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
