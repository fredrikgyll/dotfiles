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
ln -fs $HOME/dotfiles/home/* $HOME/
#create symlinks for $ZSH_CUSTOM
ln -fs $HOME/dotfiles/zsh_custom/* $ZSH_CUSTOM/

if [ ! -d /home/.vim/bundle/Vundle.vim/.git ]
then
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

source $HOME/.zshrc
echo "init complete"

