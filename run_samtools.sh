#!/bin/bash

if ls "alignment_data"/*.sam 1> /dev/null 2>&1; then
    $checker=0
fi

if  [ ! -d "bam_data" ]; then
    mkdir bam_data
fi