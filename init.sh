#!/bin/zsh
cd "${0%/*}"

#make hidden files globbable
setopt glob_dots

#create symlinks for $HOME
ln -fs $HOME/dotfiles/home/* $HOME/

if [[ ! -d /home/.vim/bundle/Vundle.vim/.git ]]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

echo "Installing all vim plugins."
vim +PluginInstall +qall

if [ "$(uname)" == "Darwin" ]; then
  echo "MacOS detected."
  which -s brew
  if [[ $? != 0 ]] ; then
    # Install Homebrew
    echo "Homebrew is not installed, installing now."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  if type xcode-select >&- && xpath=$( xcode-select --print-path ) &&
    test -d "${xpath}" && test -x "${xpath}" ; then
    echo "XCode CLI tools are installed and configured correctly."
  else
    echo "XCode CLI tools are not installed, starting installer now."
    xcode-select --install
  fi
fi

source $HOME/.zshrc
echo "init complete!"

