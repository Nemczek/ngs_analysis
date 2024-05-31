#!/bin/bash

# Check if folder "freebayes_run" doesn't exist, create it if it does
mkdir -p freebayes_run
ls sorted_data/*.bam > freebayes_run/freebayes_input.txt
# Check if there are any BAM files in the sorted_data folder
if ls "sorted_data"/*.bam &>/dev/null; then
    # If there are BAM files, run freebayes
    freebayes -f ./data/ref.fa -L freebayes_run/freebayes_input.txt > freebayes_run/freebayes_output.vcf
fi