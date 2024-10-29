#!/bin/bash


file=$1
line=$2
len=$(wc -l < "$file")
double=$(($line * 2))

if [[ -z $line ]]; then
 line=3
fi

if [[ $len -le $double ]]; then
	cat $file
else
	head -n 1 "$file"
	echo "..."
	tail -n "$line" "$file"
fi

