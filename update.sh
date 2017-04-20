#!/bin/sh
#script for puling and updating dodfiles
if [ -d .git ]; then
        echo "Pulling git repo"
        git pull
else
        echo "not in git repo"
fi

