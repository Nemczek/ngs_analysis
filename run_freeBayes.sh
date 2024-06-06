#!/bin/bash
mkdir -p vcf

# static paths to the reference files and BAM files
REFERENCE_DIR="data"
BAM_DIR="sorted_data"
REFERENCE_FASTA="${REFERENCE_DIR}/ref.fa"
REFERENCE_FAI="${REFERENCE_DIR}/ref.fa.fai"
OUTPUT_VCF="vcf/FB_penycilinum_chrysogenum_variants.vcf"

# Generate a list of BAM files
#BAM_FILES=$(ls ${BAM_DIR}/*.sorted.bam | tr '\n' ' ')
BAM_FILES=$(ls ${BAM_DIR}/*.sorted.bam | tr '\n' ' ')

# Check if BAM files exist
if [[ -z "$BAM_FILES" ]]; then
    echo "No BAM files found in the ${BAM_DIR} directory."
    exit 1
fi

BAM_LIST=$(mktemp)
for BAM_FILE in ${BAM_FILES}; do
    echo "${BAM_FILE}" >> ${BAM_LIST}
done

echo ${OUTPUT_VCF}
echo ${BAM_LIST}
cat ${BAM_LIST}

# Run FreeBayes
freebayes -f ${REFERENCE_FASTA} -p 1 -q 30 -L ${BAM_LIST} > ${OUTPUT_VCF}

# Check if FreeBayes executed successfully
if [[ $? -eq 0 ]]; then
    echo "Variant calling completed successfully. Output VCF: ${OUTPUT_VCF}"
else
    echo "Variant calling failed."
    exit 1
fi

rm ${BAM_LIST}