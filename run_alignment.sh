#!/bin/bash

checker=1

# Check if there are data in trimm_data folder
if ls "trimm_data"/*.f* 1> /dev/null 2>&1; then
    checker=0
fi

# Reset checker for the next check
checker=1

# Check for reference genome
if ls "data"/ref.fa 1> /dev/null 2>&1; then
    checker=0
     
fi


if [ $checker -eq 0 ]; then
    bwa index data/ref.fa
    mv ref.fa.* ./data/
fi

# Check if there is an index in folder
if [ ! -d "bam_data" ]; then
    mkdir bam_data
fi

files_1=()
files_2=()

for file in trimm_data/paired*_1*; do
    if [ -e "$file" ]; then
        files_1+=("$file")
    fi
done

for file in trimm_data/paired*_2*; do
    if [ -e "$file" ]; then
        files_2+=("$file")
    fi
done

# Debug: print parsed files
echo "files_1: ${files_1[@]}"
echo "files_2: ${files_2[@]}"

# Align files
for index in "${!files_1[@]}"; do
    file1=${files_1[$index]}
    file2=${files_2[$index]}
    # Extract base names without extensions
    base1=$(basename "$file1" .fq)
    base2=$(basename "$file2" .fq)
    # Debug: print file names and base names
    echo "Processing files: $file1 and $file2"
    echo "Base names: $base1 and $base2"
    bwa mem -t 4 ./data/ref.fa "$file1" "$file2" | samtools view -bS -@ 4 - > ./bam_data/${base1}.bam
    
done