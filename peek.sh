#!/bin/bash


file=$1
line=$2

head -n "$line" "$file"
echo "..."
tail -n "$line" "$file"
