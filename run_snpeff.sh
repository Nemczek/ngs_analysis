#!/bin/bash

#Data base need to be downloaded or made manually
echo "Do you downloaded database? (y/n)"
read user_answer

mkdir -p vcf_ann

if [ $user_answer = "y" ]; then
    # If there is filtered variants file 
    if ls "vcf_filtred"/*.vcf &>/dev/null; then 
       	
       	for VCF in vcf_filtred/*.vcf; do
    		SAMPLE_NAME=$(basename $VCF _vf.vcf)
       		# Annotate
        	java -jar /home/patryk/snpEff/snpEff.jar -v Penicillium_chrysogenum_gca_000710275 -stats ${SAMPLE_NAME} ./vcf_filtred/${SAMPLE_NAME}_vf.vcf > ${SAMPLE_NAME}_annotated.vcf
                mkdir -p ./vcf_ann/${SAMPLE_NAME}
        	    mv ${SAMPLE_NAME}.txt ./vcf_ann/
        done
    fi
    else
    echo "Download database manually or use snpEff database and check for your organism."
    exit 1
fi
