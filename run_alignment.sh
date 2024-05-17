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
if ls "data"/.gtf 1> /dev/null 2>&1; then
    $checker=0 

fi

if [ $checker = 0 ]; then
    bwa 

fi