#!/bin/bash

mkdir -p bfctools_run

# Ścieżka do folderu z plikami BAM
BAM_FOLDER="./sorted_bam"

# Ścieżka do pliku referencyjnego
REF_FA="./data/ref.fa"

# Znajdź wszystkie pliki BAM w folderze i połącz je w jedną linię
BAM_FILES=$(ls "$BAM_FOLDER"/*.sorted.bam | tr '\n' ' ')

# Sprawdź, czy znaleziono pliki BAM
if [ -z "$BAM_FILES" ]; then
  echo "Nie znaleziono plików BAM w folderze $BAM_FOLDER"
  exit 1
fi

# Uruchom bcftools mpileup z zebranymi plikami BAM
bcftools mpileup --threads 9 -Ou -f "$REF_FA" $BAM_FILES | bcftools call --threads 9 -vmO z -o ./bfctools_run/bfctools.vcf.gz



# Check if there is vcf file
if ls "bfctools_run"/*.vcf.gz &>/dev/null; then
    # If true, run bcf tools to variants with quality > 20
    bcftools filter -i 'QUAL > 20' ./bfctools_run/bfctools.vcf.gz -o ./bfctools_run/bfctools_vf.vcf 
fi