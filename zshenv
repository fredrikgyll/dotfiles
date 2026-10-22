# Environment variables (always loaded, all shells)

# Terminal and locale
export TERM=xterm-256color
export LANG=en_US.UTF-8

# Editor
export EDITOR=nvim

# Python
export PYTHONBREAKPOINT="pudb.set_trace"

# PGP
export GPG_TTY=$(tty)

# Bat theme
export BAT_THEME="gruvbox-dark"

# Cargo
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
