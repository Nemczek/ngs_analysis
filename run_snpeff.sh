#!/bin/bash

echo "Do you want to downlaod database? (y/n)"
read user_answer

if [ $user_answer = "y" ]; then
    snpEff download -v Penicillium_chrysogenum_gca_000710275
    echo "Downloaded databse"
fi

# If there is filtered variants file 
if ls "bfctools_run"/bfctools_vf.vcf &>/dev/null; then
    # Annotate
    snpEff -v Penicillium_chrysogenum_gca_000710275 ./bfctools_run/bfctools_vf.vcf > bfc_annotated.vcf
    mv bfc_annotated ./data
fi