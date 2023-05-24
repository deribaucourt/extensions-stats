#!/bin/bash

set -eu

directory=$1

if [ -z "$directory" ]; then
    echo "Usage: $0 <directory>"
    echo "    Prints the number of files and lines for each extension in the given directory"
    exit 1
fi

if [ ! -d "$directory" ]; then
    echo "Directory $directory does not exist"
    exit 1
fi

extensions=$(find $directory -type f -exec basename {} \; | grep -Eo '\.[^.]+$' | sort -u)

echo Extension FilesCount LinesCount

for extension in $extensions; do
    filescount=$(find "$directory" -type f -name "*$extension" | grep -c "")
    linescount=$(find "$directory" -type f -name "*$extension" -exec cat {} \; | grep -c "")
    echo "$extension $filescount $linescount"
done
