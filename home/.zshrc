export ZPLUG_HOME=$HOME/.zplug
source $ZPLUG_HOME/init.zsh

ZPLUG_SUDO_PASSWORD=
ZPLUG_PROTOCOL=ssh

zplug "b4b4r07/zplug-doctor", lazy:yes
zplug "b4b4r07/zplug-cd", lazy:yes
zplug "b4b4r07/zplug-rm", lazy:yes
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug "zsh-users/zsh-autosuggestions", use:zsh-autosuggestions.zsh, from:github
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Export histfile location
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

# Then, source plugins and add commands to $PATH
zplug load

# source aliases
source $HOME/dotfiles/home/aliases.zsh

# source vim thing
# source $ZPLUG_HOME/autoload/vim.zsh

#give Homebrew path presedence in PATH
export PATH="/usr/local/sbin:$PATH"

#add antlr to CLSSPATH
export CLASSPATH=".:/usr/local/lib/antlr-4.7.1-complete.jar:$CLASSPATH"

export EDITOR="vim"

### Autosuggestion

# bind CTRL+SPACE to autosugestion accept
bindkey '^[[99;99K' autosuggest-accept

# bind CTRL+ENTER to autosuggestion execute
bindkey '^[[99;98K' autosuggest-execute

# Strategies to use to fetch a suggestion
# Will try each strategy in order until a suggestion is returned
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd)


# Make autosugestions case insentistive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select 
#fix for locale issues when connecting to ubuntu servers
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# Virtualenvironmentsettings for Python projects on my Mac
if [[ "$(uname)" == "Darwin" ]]; then
        export WORKON_HOME=$HOME/.virtualenvs
        export PROJECT_HOME=$HOME/Projects
        export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
	export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
        source /usr/local/bin/virtualenvwrapper.sh
fi

### FZF
#source the program
[ -f ./.fzf.zsh ] && source ./.fzf.zsh

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,target,node_modules,.mypy_cache,.pytest_cache,/media,.cache,.idea}/*" -g "!*.{pyc,sql,sqlite3}" -g "!__init__.py"'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Search a file with fzf inside a Tmux pane and then open it in an editor
# Search a file with fzf inside a Tmux pane and then open it in an editor
fzf_then_open_in_editor() {
  LBUFFER="$(__fsel)"
  local f=$?
  if [[ -a "$f" ]]; then
    vim "$f"
    echo should open
  else
  zle reset-prompt;
  fi
}
# bind function to widget
zle 	-N 	fzf_then_open_in_editor
bindkey '^e' 	fzf_then_open_in_editor


export PATH=$PATH:"~/.espressif/tools/xtensa-esp32-elf/esp32-2019r1-8.2.0/xtensa-esp32-elf/bin"	
export IDF_PATH=~/esp/esp-idf
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# set up pyenv
eval "$(pyenv init -)"

python2.latest() {
  pyenv shell 2.7.15
  pyenv virtualenvwrapper
}

python3.latest() {
  pyenv shell 3.7.4
  pyenv virtualenvwrapper
}

# default to Python 2.7.15
python3.latest
