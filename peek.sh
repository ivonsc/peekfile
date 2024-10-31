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

#!/bin/bash


find . -type f -name "*.txt" | while read -r file; do

    line_count=$(wc -l < "$file")

    if [[ "$line_count" -le 20 ]]; then

        echo "File has $line_count lines, displaying full content:"
        cat "$file"
    else
        echo "WARNING: File has $line_count lines, displaying first and last 10 lines:"
        head -n 10 "$file"
        echo "..."
        tail -n 10 "$file"
    fi

done
