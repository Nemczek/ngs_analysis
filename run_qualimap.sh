#!/bin/bash

# Zmienne środowiskowe
BAM_DIR="./sorted_data"       # katalog z plikami BAM
QUALIMAP_DIR="/home/patryk/qualimap"  # katalog z QualiMap
QUALIMAP_OUTPUT_DIR="./qualimap/"  # katalog na raporty QualiMap
MULTIQC_OUTPUT_DIR="./multiqc_run/bam_multi"  # katalog na raporty MultiQC

module load bioinfo-tools
module load QualiMap/2.2.1

export JAVA_TOOL_OPTIONS="-Xmx1200M"

# Tworzenie katalogu wyjściowego, jeśli nie istnieje
mkdir -p $QUALIMAP_OUTPUT_DIR
mkdir -p $MULTIQC_OUTPUT_DIR

# Iteracja po wszystkich plikach BAM w katalogu
for BAM in $BAM_DIR/*.sorted.bam; do
    SAMPLE_NAME=$(basename $BAM .sorted.bam)

    # Checkpoint: Analiza jakości za pomocą QualiMap
    echo "Analiza jakości dla próbki $SAMPLE_NAME..."
    
    $QUALIMAP_DIR/qualimap bamqc -bam $BAM -outdir $QUALIMAP_OUTPUT_DIR${SAMPLE_NAME}
    if [ $? -ne 0 ]; then
        echo "Błąd analizy jakości dla próbki $SAMPLE_NAME."
        continue
    fi
done

echo "Generowanie zbiorczego raportu za pomocą MultiQC..."
multiqc $QUALIMAP_OUTPUT_DIR -o $MULTIQC_OUTPUT_DIR

echo "Proces analizy jakości i generowania raportu zakończony."

