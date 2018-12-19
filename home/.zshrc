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
source $HOME/dotfiles/.aliases

#give Homebrew path presedence in PATH
export PATH="/usr/local/sbin:$PATH"

#add antlr to CLSSPATH
export CLASSPATH=".:/usr/local/lib/antlr-4.7.1-complete.jar:$CLASSPATH"

# bind ESC+ENTER to autosugestion accept
bindkey '^[^M' autosuggest-accept

# Make autosugestions case insentistive
zstyle ':completion:*' menu select matcher-list 'm:{a-z}={A-Za-z}'

#fix for locale issues when connecting to ubuntu servers
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8


# Virtualenvironmentsettings for Python projects
if [ "$LOCAL_MAC" = "local" ]
then
        export WORKON_HOME=$HOME/.virtualenvs
        export PROJECT_HOME=$HOME/Projects
        export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
        source /usr/local/bin/virtualenvwrapper.sh
fi
