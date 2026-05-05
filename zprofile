# Login shell configuration (PATH setup)

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Node version manager (fnm)
eval "$(fnm env --use-on-cd --shell zsh)"

export PATH="$HOME/.local/bin:$PATH"
