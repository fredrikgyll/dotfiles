#!/bin/sh
cd $HOME/dotfiles/
#Install oh-my-zsh if it isnt already
if [ ! -d "$HOME/.oh-my-zsh" ]
then
            sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    fi
#create symlinks
for file in `ls -A HOME/`
do
        ln -fs $HOME/dotfiles/HOME/$file $HOME/$file
done
for file in `ls -A ZSH_CUSTOM`
do
	ln -fs $HOME/dotfiles/ZSH_CUSTOM/$file $ZSH_CUSTOM/$file
done
mkdir -p $HOME/.vim/colors
ln -fs $HOME/dotfiles/.vim/colors/darcula.vim $HOME/.vim/colors/darcula.vim
source $HOME/.zshrc
echo "init complete"

