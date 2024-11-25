#!/bin/bash

# Define arguments
file_X=${1:-$(pwd)}
N_lines=${2:-0}

# Header
echo "#################################################################"
echo "################## FASTASCAN.SH REPORT ##########################"
echo "#################################################################"

# Find all FASTA files
fastas=$(find "$file_X" -type f \( -name "*.fasta" -or -name "*.fa" \))
num_fastas=$(echo "$fastas" | wc -l)

# Check if FASTA files exist
if [[ $num_fastas -eq 0 ]]; then
  echo "No FASTA files found in the specified directory."
  exit 1
fi

echo "Number of FASTA files: $num_fastas"
echo

# Unique FASTA IDs
echo "Unique FASTA IDs:"
for file in $fastas; do
  grep '>' "$file" | sort -u | awk '{print $1}'
done

# Process each FASTA file
for file in $fastas; do
  echo
  echo "==========================================================================================================="
  echo "======= FileName: $file ======="
  echo "==========================================================================================================="
  
  # Symlink check
  echo "Symlink:"
  [[ -h "$file" ]] && echo "This fasta file is a Symlink." || echo "This fasta file is not a Symlink."
  
  # Number of sequences
  echo "Number of sequences:"
  grep -c '>' "$file"

  # Total sequence length
# Total sequence length
cleaned_sequences=$(grep -v '>' "$file" | tr -d ' \n-')
total_length=$(echo -n "$cleaned_sequences" | wc -c)
echo "Total sequence length: $total_length"

  # Type of biomolecule
  echo "Type of biomolecule:"
  if echo "$sequence" | grep -iqE '[DEFHIKLMPQRSVWY]'; then
    echo "Amino Acid Sequence"
  elif echo "$sequence" | grep -iqE '[ATGCU]'; then
    echo "Nucleotide"
  else
    echo "Unknown"
  fi

  # Display file content based on N_lines
  if [[ $N_lines -ne 0 ]]; then
    total_lines=$(cat "$file" | wc -l)
    if [[ $total_lines -le $((2 * N_lines)) ]]; then
      cat "$file"
    else
      head -n "$N_lines" "$file"
      echo "..."
      tail -n "$N_lines" "$file"
    fi
  fi
done
