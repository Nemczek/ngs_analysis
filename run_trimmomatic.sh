#!/bin/bash

echo "MultiQC raport created in /multiqc_run/ngs_project*.html"
echo "Opening NGS Project"

sleep 2
xdg-open ./multiqc_run/ngs_project*.html 2>/dev/null &
sleep 3

echo "Do you want to proceed ? (y/n)"
read user_answer

if [ "$user_answer" = "y" ]; then
    echo "Pass trimmomatic arguments (SLIDINGWINDOW:4:20 included)"
    read trimm_args

    if [ ! -d "trimm_data" ]; then
        mkdir trimm_data
    fi

    # Parsing files to arrays
    files_1=()
    files_2=()

    for file in data/*_1.fastq.gz; do
        if [ -e "$file" ]; then
            files_1+=("$file")
        fi
    done

    for file in data/*_2.fastq.gz; do
        if [ -e "$file" ]; then
            files_2+=("$file")
        fi
    done

    # Debug: print parsed files
    echo "files_1: ${files_1[@]}"
    echo "files_2: ${files_2[@]}"

    # Trimm files with args
    for index in "${!files_1[@]}"; do
        file1=${files_1[$index]}
        file2=${files_2[$index]}

        # Extract base names without extensions
        base1=$(basename "$file1" .fastq.gz)
        base2=$(basename "$file2" .fastq.gz)

        # Debug: print file names and base names
        echo "Processing files: $file1 and $file2"
        echo "Base names: $base1 and $base2"

        echo "Trimmomatic PE $file1 $file2"
        trimmomatic PE "$file1" "$file2" "paired_${base1}.fq" "unpaired_${base1}.fq" "paired_${base2}.fq" "unpaired_${base2}.fq" SLIDINGWINDOW:4:20 $trimm_args
        if [ $? -ne 0 ]; then
            echo "Trimmomatic failed. Exiting"
            exit 1
        fi
    done
    mv unpaired_* trimm_data
    mv paired_* trimm_data
    echo "All done!"
    
else
    echo "Exiting"
    exit 0
fi

mv unpaired_* trimm_data
mv paired_* trimm_data