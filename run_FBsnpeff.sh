#!/bin/bash

#Data base need to be downloaded or made manually
echo "Do you downloaded database? (y/n)"
read user_answer

if [ $user_answer = "y" ]; then
    # If there is filtered variants file 
    if ls "freebayes_run"/freebayes_vf.vcf &>/dev/null; then
        # Annotate
        snpEff -v Penicillium_chrysogenum ./freebayes_run/freebayes_vf.vcf > FB_annotated.vcf
        mv FB_annotated.vcf ./data
    fi
    else
    echo "Download database manually or use snpEff database and check for your organism."
    exit 1
fi

