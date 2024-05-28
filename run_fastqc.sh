#!/bin/bash

# Check if folder "fastqc_run" doesn't exists. 
if  [ ! -d "fastqc_run" ]; then
    mkdir fastqc_run
fi

# If there are any files in folder, ask if user wants to delete them
if ls "fastqc_run"/*.fastqc 1> /dev/null 2>&1; then
    echo "Do you want to delete all files in directory? (y/n)"
    read user_answer

    if [ $user_answer = "y" ]; then
        rm fastqc_run/*.fastqc
    fi
fi

# Run fastqc
fastqc -o fastqc_run ./data/*.f*


