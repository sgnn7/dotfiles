#!/bin/bash -e

files_to_change=$(find . -name '*.py')

for file in $files_to_change; do
    echo $file
    cat $file > dummy
    cat header dummy > $file
done
