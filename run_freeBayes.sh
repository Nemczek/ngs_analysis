#!/bin/bash

# Check if folder "freebayes_run" doesn't exist, create it if it does
mkdir -p freebayes_run

for BAM in sorted_data/*sorted.bam; do
    SAMPLE_NAME=$(basename $BAM _sorted.bam)
    freebayes -f data/ref.fa -q 30 -b $BAM > freebayes_run/${SAMPLE_NAME}.vcf
done