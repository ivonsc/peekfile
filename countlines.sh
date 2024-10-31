#!/bin/bash

for file in "$@"; do

    line_count=$(wc -l < "$file")

    if [[ "$line_count" -gt 1 ]]; then
        echo "$file has $line_count lines"
    elif [[ "$line_count" -eq 1 ]]; then
        echo "$file has one line"
    else
        echo "$file has zero lines"
    fi
done
