autoload -U compinit; compinit

export TERM=xterm-256color
export LANG=en_US.UTF-8
export EDITOR=/opt/homebrew/bin/nvim
export PYTHONBREAKPOINT="pudb.set_trace"

### History
export HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.


# use emacs keymap so standard C-A/E/K etc work in shell
####bindkey -e

### Direnv
if command -v direnv 1>/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi
#


# PGP
export GPG_TTY=$(tty)

### Aliases
alias la="eza -al --git-ignore --group-directories-first --git"
alias laa="eza -al --group-directories-first"
alias v=nvim
alias vi=nvim
alias vim=nvim
alias g=git
alias gs="git status"
alias gl="git lg -25"
alias gcm="git checkout master"
alias szsh="source $HOME/.zshrc"
alias ezsh="vim $HOME/.zshrc"

alias cloudrestart="cd $HOME/dev/cloud && uv sync --frozen --inexact && rm -rf build/ && yarn && yarn build && uv run --frozen python manage.py migrate && uv run --frozen python manage.py collectstatic --no-input --no-post-process"

### FZF
export BAT_THEME="gruvbox-dark"
# How to invoke the fzf command, especially in fzf.vim
    # --files: List files that would be searched but do not search
    # --no-ignore: Do not respect .gitignore, etc...
    # --hidden: Search hidden files and folders
    # --follow: Follow symlinks
    # --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
####export FZF_DEFAULT_COMMAND='rg --smart-case --files --hidden --follow --glob "!.git/*"'

export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target,.mypy_cache,build,__pycache__,.ruff_cache,.pytest_cache,locale,tmp
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"


source <(fzf --zsh)

### Better history search
#autoload -U up-line-or-beginning-search
#autoload -U down-line-or-beginning-search
#zle -N up-line-or-beginning-search
#zle -N down-line-or-beginning-search
#bindkey "[A" up-line-or-beginning-search # Up
#bindkey "[B" down-line-or-beginning-search # Down

###Kitty

# Completion for kitty
#kitty + complete setup zsh | source /dev/stdin


### MOTD
####function echo_color() {
####  local color="$1"
####  printf "${color}$2\033[0m\n"
####}

####echo_color "\033[0;90m" "c-f  Move forward"
####echo_color "\033[0;90m" "c-b  Move backward"
####echo_color "\033[0;90m" "c-p  Move up"
####echo_color "\033[0;90m" "c-n  Move down"
####echo_color "\033[0;90m" "c-h  Delete backward"

# Prompt
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

#bindkey '\e[A' history-beginning-search-backward
#bindkey '\e[B' history-beginning-search-forward

