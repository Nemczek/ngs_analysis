#!/bin/bash

mkdir -p vcf

# Ścieżka do folderu z plikami BAM
BAM_FOLDER="./sorted_data"

# Ścieżka do pliku referencyjnego
REF_FA="./data/ref.fa"

# Znajdź wszystkie pliki BAM w folderze i połącz je w jedną linię
BAM_FILES=$(ls ${BAM_FOLDER}/*.sorted.bam)

# Sprawdź, czy znaleziono pliki BAM
if [ -z "$BAM_FILES" ]; then
  echo "Nie znaleziono plików BAM w folderze $BAM_FOLDER"
  exit 1
fi


bcftools mpileup --threads 9 -Ou -f "$REF_FA" $BAM_FOLDER/*.sorted.bam | bcftools call --threads 9 --ploidy 1 -vmO z -o vcf/bfc_penycilinum_chrysogenum_variants.vcf

#mv bfc_penycilinum* vcf