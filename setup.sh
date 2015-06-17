#!/bin/bash

DIR=$1

if [ -z $DIR ]; then
    echo "Usage: ./setup.sh DIR"
    echo "       where DIR is the name of the data directory."
    echo "Example: ./setup.sh Obituaries"
    exit 1
fi

cp .scan.php.default scan.php || exit 1

echo "Editing directory name..."
sed --in-place -re "s/DIRNAME_GOES_HERE/$DIR/g" scan.php
