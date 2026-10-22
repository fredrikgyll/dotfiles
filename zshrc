# Zsh interactive shell configuration
LC_CTYPE="en_US.UTF-8"
### Completion
autoload -Uz compinit
# Only regenerate compdump once per day for better performance
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qNmh+24) ]]; then
  compinit
else
  compinit -C
fi

### History
export HISTFILE=~/.zsh_history
HISTSIZE=100000                  # Keep 100k in memory (fast)
SAVEHIST=999999999               # Keep everything on disk (your life story!)
setopt INC_APPEND_HISTORY        # Write to history file immediately
setopt EXTENDED_HISTORY          # Write timestamp and duration
setopt HIST_FIND_NO_DUPS         # Don't display duplicates in search
setopt HIST_IGNORE_ALL_DUPS      # Delete old entry if new is duplicate

### Quality of life options
setopt AUTO_CD                   # cd by typing directory name
setopt AUTO_PUSHD                # Make cd push old directory onto stack
setopt PUSHD_IGNORE_DUPS         # Don't push duplicates
setopt CORRECT                   # Spelling correction for commands
setopt COMPLETE_IN_WORD          # Complete from both ends of word

### Direnv
if command -v direnv 1>/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

### Aliases
alias la="eza -al --git-ignore --group-directories-first --git"
alias laa="eza -al --group-directories-first"
alias v=nvim
alias vi=nvim
alias vim=nvim
alias g=git
alias gs="git status"
alias gl="git lg -25"
alias gcm="git checkout main"
alias szsh="source $HOME/.zshrc"
alias ezsh="vim $HOME/.zshrc"

if [[ "$OSTYPE" == darwin* ]]; then
  alias tailscale=Tailscale
fi

### FZF
export FZF_CTRL_T_OPTS="
  --walker-skip .git
  --walker-opts='--no-ignore-parent,--git-ignore'
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

if command -v fzf 1>/dev/null 2>&1; then
  source <(fzf --zsh)
fi

### Prompt (Starship)
if command -v starship 1>/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

### Plugins
for f in /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
         $HOME/.local/share/zsh-autosuggestions/zsh-autosuggestions.zsh; do
  if [[ -f $f ]]; then source $f; break; fi
done

### Key bindings (emacs mode)
bindkey -e  # Enable emacs-style key bindings (Ctrl-A, Ctrl-E, etc.)

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

#mise
if command -v mise 1>/dev/null 2>&1; then
  eval "$(mise activate -s zsh)"
fi

if command -v zoxide 1>/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

### Machine-local overrides (not tracked)
if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi

