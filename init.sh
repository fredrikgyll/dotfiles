#!/bin/zsh
cd $HOME/dotfiles/

#Install oh-my-zsh if it isnt already
sh -c "$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)" -s --batch || {
  echo "Could not install Oh My Zsh" >/dev/stderr
    exit 1
    }

#make hidden files globbable
setopt glob_dots

#create symlinks for $HOME
ln -fs $HOME/dotfiles/HOME/* $HOME/
#create symlinks for $ZSH_CUSTOM
ln -fs $HOME/dotfiles/ZSH_CUSTOM/* $ZSH_CUSTOM/

#create dir and symlink darcula theme
mkdir -p $HOME/.vim/colors
ln -fs $HOME/dotfiles/.vim/colors/darcula.vim $HOME/.vim/colors/darcula.vim
source $HOME/.zshrc
echo "init complete"

