
file_X=$1
N_lines=$2

if [[ -z $1 ]]; then
	file_X=$(pwd)
fi

if [[ -z $2 ]]; then
	N_lines=0
fi

echo #################################################################
echo ################## FASTASCAN:SH REPORT ##########################
echo #################################################################

#how many files there are

fastas=$(find $1 -type f -name "*.fasta" -or -name "*.fa")
echo Number of FASTA files:
echo "$fastas" | wc -l
echo

#unique fasta IDs
echo Unique FASTA IDs:
echo "$fastas" | while read file; do
	grep '>' "$file" | sort | uniq | awk '{ split($0, A," "); print A[1] }'
	echo
done

#for each file

echo "$fastas" | while read file; do
	echo
	echo
	# HEADER
	echo ===========================================================================================================
	echo ======= FileName: $file  ========
	echo ===========================================================================================================

	#SYMLINK
	echo
	echo Symlink:
	echo
	if [[ -h $file ]]; then
		echo This fasta file is a Symlink.
	else
		echo This fasta file is not a Symlink.
	fi
	echo
	echo -----------------------------------------------------------------------------------------------------------
	echo
	#HOW MANY SEQs
	echo Number of sequences:
	echo
	grep -c '>' "$file"
	echo
	echo -----------------------------------------------------------------------------------------------------------
	echo
	#TOTAL SEQ LENGTH
	corrected_file=$(sed  -e 's/-//g' -e 's/ //g' -e 's/\n//g' "$file")
	sequence=$(echo "$corrected_file" | grep -v '>')

	echo Total sequence length:
	echo
	echo "$sequence" | wc -c
	echo
	echo -----------------------------------------------------------------------------------------------------------
	#NUCLEOTIDES PROTEIN SEQ
	echo
	echo Type of biomolecule:
	echo
	# Check if the sequence contains any non-nucleotide characters
	echo "$sequence" | while read seq_line; do

		if echo $seq_line | grep -iqE '[DEFHIKLMPQRSVWYdefhiklmpqrsvwy]' ; then
			echo "Amino Acid Sequence"
			break

		elif echo $seq_line | grep -iqE '[ATGCUatgcu]' ; then
			echo "Nucleotide"
			break
		else
			continue
		fi
	done
	echo
	echo ------------------------------------------------------------------------------------------------------------
	#if the file has 2N lines or fewer, then display its full content; if not, show the first N lines, then "...", then the last N lines. If N is 0, skip this step.
	echo
	if [[ N_lines -eq 0 ]]; then

		continue

	else 
		echo Displaying content of file:

		if [[ N_lines -le $((2 * $(cat "$file" | wc -l) )) ]]; then
			echo Displaying content of file:
			cat $file
	 	else
			head -n "$N_lines" $file
			echo
			echo ...
			echo
			tail -n "$N_lines" $file
		fi
	fi

#EOF
done

