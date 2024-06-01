#!/bin/bash

echo "Do you want to downlaod database? (y/n)"
read user_answer

if [ $user_answer = "y" ]; then
    snpEff download -v Penicillium_chrysogenum_gca_000710275
    echo "Downloaded databse"
fi

# If there is filtered variants file 
if ls "freebayes_run"/variants_filtered.vcf &>/dev/null; then
    # Annotate
    snpEff annotate -v Penicillium_chrysogenum_gca_000710275 ./freebayes_run/variants_filtered.vcf > annotated.vcf
    mv annotated.vcf ./data
fi

