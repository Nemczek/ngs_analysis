#!/bin/bash

mkdir -p vcf_filtred

if ls "vcf"/*.vcf &>/dev/null; then
    # If true, run bcf tools to variants with quality > 20
    for VCF in vcf/*.vcf; do
    	SAMPLE_NAME=$(basename $VCF .vcf)
    	bcftools filter -i 'QUAL > 30' ./vcf/${SAMPLE_NAME}.vcf -o ./vcf_filtred/${SAMPLE_NAME}_vf.vcf 
    done
    else
        echo "No vcf files found in vcf folder"
        exit 1
fi