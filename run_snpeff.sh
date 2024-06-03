#!/bin/bash

#Data base need to be downloaded or made manually
echo "Do you downloaded database? (y/n)"
read user_answer

if [ $user_answer = "y" ]; then
# If there is filtered variants file 
    if ls "bfctools_run"/bfctools_vf.vcf &>/dev/null; then
        # Annotate
        snpEff -v Penicillium_chrysogenum ./bfctools_run/bfctools_vf.vcf > bfc_annotated.vcf
        mv bfc_annotated.vcf ./data
    fi
    else
    echo "Download database manually or use snpEff database and check for your organism."
    exit 1

fi