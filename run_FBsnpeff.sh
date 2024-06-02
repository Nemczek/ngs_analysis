#!/bin/bash

echo "Do you want to downlaod database? (y/n)"
read user_answer

if [ $user_answer = "y" ]; then
    snpEff download -v Penicillium_chrysogenum_gca_000710275
    echo "Downloaded databse"
fi

# If there is filtered variants file 
if ls "freebayes_run"/freebayes_vf.vcf &>/dev/null; then
    # Annotate
    snpEff -v Penicillium_chrysogenum_gca_000710275 ./freebayes_run/freebayes_vf.vcf > FB_annotated.vcf
    mv FB_annotated ./data
fi

