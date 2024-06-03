#!/bin/bash

# Check if folder "freebayes_run" doesn't exist, create it if it does
mkdir -p freebayes_run

for BAM in sorted_data/*sorted.bam; do
    SAMPLE_NAME=$(basename $BAM _sorted.bam)
    freebayes -f data/ref.fa -q 30 -b $BAM > freebayes_run/${SAMPLE_NAME}.vcf
done

BAM_FOLDER="./sorted_data"
BAM_FILES=$(ls "$BAM_FOLDER"/*.sorted.bam | tr '\n' ' ')


freebayes \
	--fasta-reference data/ref.fa \
	--bam-list $BAM_FILES \
	-- vcf ./freebayes_run/freebayes.vcf \

# Check if there is vcf file
if ls "freebayes_run"/*.vcf &>/dev/null; then
    # If true, run bcf tools to variants with quality > 20
    bcftools filter -i 'QUAL > 20' ./freebayes_run/*.vcf -o ./freebayes_run/freebayes_vf.vcf 
fi