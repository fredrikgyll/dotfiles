#!/bin/sh
cd $HOME/dotfiles/
#Install oh-my-zsh if it isnt already
if [ ! -d "$HOME/.oh-my-zsh" ]
then
        echo "installing Oh my zsh..."
        sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    fi
#create symlinks

for dir in HOME ZSH_CUSTOM
do
        for file in `ls -A $dir`
        do
                ln -fs $HOME/dotfiles/$dir/$file $HOME/$file
        done
done

#create dir and symlink darcula theme
mkdir -p $HOME/.vim/colors
ln -fs $HOME/dotfiles/.vim/colors/darcula.vim $HOME/.vim/colors/darcula.vim
source $HOME/.zshrc
echo "init complete"

