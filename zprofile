# Set PATH, MANPATH, etc., for Homebrew.

# Brew
eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(fnm env --use-on-cd --shell zsh)"

#Poetry
export PATH="/Users/fredrikgy/.local/bin:$PATH"
export PATH="/usr/local/share/texlive/2018/bin/universal-darwin:$PATH"

# Bat theme
export BAT_THEME="gruvbox-dark"
