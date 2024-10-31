file=$1

if [[ $(wc -l < "$file") -gt 1 ]]; then
	echo "$1" has $(wc -l < "$file") lines
elif [[ $(wc -l < "$file") -eq 1 ]]; then
	echo "$1" has one line
else
	echo "$1" has zero lines
fi
