# Login shell configuration (PATH setup)

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Node version manager (fnm)
eval "$(fnm env --use-on-cd --shell zsh)"

export PATH="$HOME/.local/bin:$PATH"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
