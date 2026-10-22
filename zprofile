# Login shell configuration (PATH setup)

if [[ "$OSTYPE" == darwin* ]]; then
  # Homebrew
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # Add Tailscale to Path
  export PATH="/Applications/Tailscale.app/Contents/MacOS:$PATH"

  # Added by OrbStack: command-line tools and integration
  # This won't be added again if you remove it.
  source ~/.orbstack/shell/init.zsh 2>/dev/null || :
fi

export PATH="$HOME/.local/bin:$PATH"

# Node version manager (fnm)
if command -v fnm 1>/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi
