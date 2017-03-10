#!/bin/bash

echo "Install Snippets"
mkdir $HOME/.vim
ln -s $PWD/UltiSnips $HOME/.vim/UltiSnips

echo "Install config files"

cd config

for FILE in $(echo .[^.]*); do
    
    if [ -f ~/$FILE ]; then
        echo "Backing up $FILE to ${FILE}.old_"$(date +%Y-%m-%dT%T)
        mv ~/$FILE ~/${FILE}.old_$(date +%Y-%m-%dT%T)
    fi

    if [ -L ~/$FILE ]; then
        echo "Removing old symlink to $FILE"
        rm ~/$FILE
    fi

    echo "Creating new symlink to $FILE"
    ln -s $PWD/$FILE $HOME/$FILE
done
