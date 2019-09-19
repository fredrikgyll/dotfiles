#!/bin/sh
#script for puling and updating dodfiles

cd ~/dotfiles/
git pull
source init.sh
echo "update complete"
