#!/bin/bash

echo "Install config files"

cd config

for FILE in $(echo .[^.]*); do
    
    if [ -f ~/$FILE ]; then
        echo "Backing up $FILE to ${FILE}.old"
        mv ~/$FILE ~/${FILE}.old
    fi

    if [ -L ~/testdir/$FILE ]; then
        echo "Removing old symlink to $FILE"
        rm ~/$FILE
    fi

    echo "Creating new symlink to $FILE"
    ln -s $PWD/$FILE $HOME/$FILE
done
