#!/bin/bash

echo "MultiQC raport created in /multiqc_run/ngs_project.html"
open /multiqc_run/ngs_project.html

echo "Do you want to proceed ? (y/n)"
read user_answer

if [ $user_answer = "y" ]
    echo "Pass trimmomatic arguments (SLIDINGWINDOW:4:20 included)"
    read trimm_args

    if  [ ! -d "trimm_data" ]; then
    mkdir trimm_data
    fi
   
    # Parsing files to arrays
    files_1=()
    files_2=()

    for file in data/*_1; 
    do
        if [ -e $file ]; then
            files_1+=$file
        fi
    done

    for file in data/*_2; 
    do
        if [ -e $file ]; then
            files_2+=$file
        fi
    done

    # Trimm files with args
    for index in "${!files_1[@]}";
    do
        file1=${files_1[$index]}
        file2=${files_2[$index]}

        trimmomatic PE $file1 $file2 paired_${file1} unpaired_${file1} paired_${file2} unpaired_${file2} SLIDINGWINDOW:4:20 $trimm_args
    done

    mv unpaired_* trimm_data
    mv paired_* trimm_data
    
fi