#!/bin/bash

DIR=$1
CD=$(pwd)

pwd

cd $CD/assets/css
if [ -e "./styles_large.css" ]; then
    mv styles.css styles_small.css
    mv styles_large.css styles.css
fi
cd ../..

if [ -z $DIR ]; then
    echo "Usage: ./setup.sh DIR [--small]"
    echo "       where DIR is the name of the data directory."
    echo "       Add --small to use the more compact CSS styles."
    echo "Example: ./setup.sh Obituaries"
    exit 1
fi

CSS=$2

if [ ! -z $CSS ] && [ $CSS = "--small" ]; then
    cd $CD/assets/css
    mv styles.css styles_large.css
    mv styles_small.css styles.css
    cd ../..
fi

cp .scan.php.default scan.php || exit 1

echo "Editing directory name..."
sed --in-place -re "s/DIRNAME_GOES_HERE/$DIR/g" scan.php
