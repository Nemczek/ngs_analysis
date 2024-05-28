#!/bin/bash

checker=1

# Check if there are data in trimm_data folder
if ls "trimm_data"/*.f* 1> /dev/null 2>&1; then
    $checker=0
fi

if  [ ! -d "alignment_data" ]; then
    mkdir alignment_data
fi

# check for reference genom
if ls "data"/ref.fa 1> /dev/null 2>&1; then
    $checker=0 

fi

if [ $checker = 0 ]; then
    bwa index -p "index" ./data/ref.fa

fi

# Check if there are index in folder
if ls ./index* 1> /dev/null 2>&1; then
    $checker=0 

fi

files_1=()
files_2=()

for file in timm_data/paired*_1*; 
    do
        if [ -e $file ]; then
            files_1+=$file
        fi
    done

for file in trimm_data/paired*_2*; 
    do
        if [ -e $file ]; then
            files_2+=$file
        fi
    done



if [ $checker = 0 ]; then
    for index in "${!files_1[@]}";
    do
        file1=${files_1[$index]}
        file2=${files_2[$index]}

        bwa mem data/ref.fa ${file1} ${file2} > ${file1}.sam
    done
fi