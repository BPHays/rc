#!/bin/bash

echo "Install config files"

cd config

for FILE in $(echo .[^.]*); do
    
    if [ -f ~/testdir/$FILE ]; then
        echo "Backing up $FILE to ${FILE}.old"
        mv ~/testdir/$FILE ~/testdir/${FILE}.old
    fi

    if [ -L ~/testdir/$FILE ]; then
        echo "Removing old symlink to $FILE"
        rm ~/testdir/$FILE
    fi

    echo "Creating new symlink to $FILE"
    ln -s $PWD/$FILE $HOME/testdir/$FILE
done
