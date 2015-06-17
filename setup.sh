#!/bin/bash

DIR=$1

cd ./assets/css
if [ -e "./styles_large.css" ]; then
    mv styles.css styles_small.css
    mv styles_large.css styles.css
    cd ../..
fi

if [ -z $DIR ]; then
    echo "Usage: ./setup.sh DIR"
    echo "       where DIR is the name of the data directory."
    echo "Example: ./setup.sh Obituaries"
    exit 1
fi

CSS=$2

if [ $CSS = "--small" ]; then
    cd ./assets/css
    mv styles.css styles_large.css
    mv styles_small.css styles.css
    cd ../..
fi

cp .scan.php.default scan.php || exit 1

echo "Editing directory name..."
sed --in-place -re "s/DIRNAME_GOES_HERE/$DIR/g" scan.php
