#!/bin/bash

if  [ ! -d "sorted_data" ]; then
    mkdir sorted_data
fi



files=()


for file in bam_data/*.bam; do
    if [ -e "$file" ]; then
        files+=("$file")
    fi
done

# Debug: print parsed files
echo "files: ${files[@]}"

# Align files
for index in "${!files[@]}"; do
    file=${files[$index]} 
    # Extract base names without extensions
    base=$(basename "$file" .bam)
    # Debug: print file names and base names
    echo "Processing file: $file"
    echo "Base name: $base"
# Run samtools
	
   	samtools sort -@ 4 "$file" -o ./sorted_data/${base}.sorted.bam
    samtools index -@ 4 ./sorted_data/${base}.sorted.bam
    samtools markdup -@ 4 ./sorted_data/${base}.sorted.bam
    samtools flagstat -@ 4 ./sorted_data/${base}.sorted.bam
    samtools depth -@ 4 ./sorted_data/${base}.sorted.bam

done
