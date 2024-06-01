#!/bin/bash

# Check for gff
if ls "data"/*.gff 1> /dev/null 2>&1; then
    checker=0
fi