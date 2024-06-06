#!/bin/bash

ANN_DIR="vcf_ann"
OUTPUT_DIR="filtred_vcf_ann"
echo $ANN_DIR
mkdir -p $OUTPUT_DIR

if ls $ANN_DIR/*_annotated.vcf &>/dev/null; then
    for VCF in $ANN_DIR/*_annotated.vcf; do
    	SAMPLE_NAME=$(basename $VCF _annotated.vcf)
    	java -jar /home/patryk/snpEff/SnpSift.jar filter "( ANN[*].IMPACT = 'HIGH' )" ${ANN_DIR}/${SAMPLE_NAME}_annotated.vcf > ${OUTPUT_DIR}/${SAMPLE_NAME}filtered_ann.vcf
    done
    else
        echo "No vcf files found in vcf folder"
        exit 1
fi