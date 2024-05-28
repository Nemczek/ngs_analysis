#!/bin/bash
checker=1

if ls "bam_data"/*.bam 1> /dev/null 2>&1; then
    checker=0
fi

if  [ ! -d "sorted_data" ]; then
    mkdir sorted_data
fi


# Run samtools
if [ $checker = 0 ]; then
    
    samtools sort -o ./bam_data/*.sorted.bam sorted_data/*.bam
    samtools index ./bam_data/*.sorted.bam
    
fi