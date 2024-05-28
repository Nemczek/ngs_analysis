#!/bin/bash

checker=1

# Check if there are raports in fastqc_run folder
if ls "fastqc_run"/*.html 1> /dev/null 2>&1; then
    $checker=0
fi

# Run multiqc
if [ $checker = 0 ]; then
    
    if  [ ! -d "multiqc_run" ]; then
        mkdir multiqc_run
    fi

    if ls "multiqc_run"/* 1> /dev/null 2>&1; then
    echo "Do you want to delete all files in directory? (y/n)"
    read user_answer

    if [ $user_answer = "y" ]; then
        rm multiqc_run/*
    fi

    multiqc --outdir multiqc_run  --title ngs_project
    open multiqc_run/ngs_project.html
fi