#!/bin/bash

# Check if there is vcf file
if ls "freebayes_run"/*.vcf &>/dev/null; then
    # If true, run bcf tools to variants with quality > 20
    bcftools filter -i 'QUAL > 20' ./freebayes_run/freebayes_output.vcf -o ./freebayes_run/variants_filtered.vcf 
fi