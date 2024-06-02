#!/bin/bash

# Run FastQC
echo "Running FastQC..."
bash run_fastqc.sh
if [ $? -ne 0 ]; then
    echo "FastQC failed. Exiting."
    exit 1
fi

# Merge Reports
echo "Merging reports..."
bash merge_raports.sh
if [ $? -ne 0 ]; then
    echo "Merging reports failed. Exiting."
    exit 1
fi

# Ask if the user wants to continue with Trimmomatic
echo "Would you like to continue with Trimmomatic? (y/n)"
read user_input
if [ "$user_input" != "y" ]; then
    echo "Exiting."
    exit 0
fi

while true; do
    # Run Trimmomatic
    echo "Running Trimmomatic..."
    bash run_trimmomatic.sh
    if [ $? -ne 0 ]; then
        echo "Trimmomatic failed. Exiting."
        exit 1
    fi

    # Ask if the user wants to restart the process
    echo "Would you like to restart the process from the beginning? (y/n)"
    read user_input
    if [ "$user_input" != "y" ]; then
        break
    fi

    # Run FastQC again
    echo "Running FastQC..."
    bash run_fastqc.sh
    if [ $? -ne 0 ]; then
        echo "FastQC failed. Exiting."
        exit 1
    fi

    # Merge Reports again
    echo "Merging reports..."
    bash merge_raports.sh
    if [ $? -ne 0 ]; then
        echo "Merging reports failed. Exiting."
        exit 1
    fi

    # Ask if the user wants to continue with Trimmomatic
    echo "Would you like to continue with Trimmomatic? (y/n)"
    read user_input
    if [ "$user_input" != "y" ]; then
        echo "Exiting."
        exit 0
    fi
done

# Run Alignment
echo "Running Alignment..."
bash run_alignment.sh
if [ $? -ne 0 ]; then
    echo "Alignment failed. Exiting."
    exit 1
fi

# Run Samtools
echo "Running Samtools..."
bash run_samtools.sh
if [ $? -ne 0 ]; then
    echo "Samtools failed. Exiting."
    exit 1
fi



# Run Bcftools
echo "Running bcftools..."
bash run_bcftools.sh
if [ $? -ne 0 ]; then
    echo "bcftools failed. Exiting."
    exit 1
fi


# Run snpEff
echo "Running snpEff..."
bash run_snpeff.sh
if [ $? -ne 0 ]; then
    echo "snpEff failed. Exiting."
    exit 1
fi


# Run FreeBayes
echo "Running FreeBayes..."
bash run_freeBayes.sh
if [ $? -ne 0 ]; then
    echo "FreeBayes failed. Exiting."
    exit 1
fi


echo "Running snpEff..."
bash run_FBsnpeff.sh
if [ $? -ne 0 ]; then
    echo "snpEff failed. Exiting."
    exit 1
fi

echo "Pipeline completed successfully."
