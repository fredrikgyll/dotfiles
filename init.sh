#!/bin/sh
#Install oh-my-zsh if it isnt already
if [ ! -d "$HOME/.oh-my-zsh" ]; then
          # Control will enter here if $DIRECTORY doesn't exist.
            sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
  fi
#create symlinks
ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/.vimrc $HOME/.vimrc
ln -s $HOME/dotfiles/zshcustom/aliases.zsh $ZSH_CUSTOM/aliases.zsh
mkdir -p $HOME/.vim/colors
ln -s $HOME/dotfiles/.vim/colors/darcula.vim $HOME/.vim/colors/darcula.vim
source $HOME/.zshrc
echo "init complete"

