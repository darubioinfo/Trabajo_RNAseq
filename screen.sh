#!/bin/bash

#specifica el directorio donde se encuentran tus archivos fastq
FASTQ_DIR="transcriptomic-final-exercise/Apartado1/output/trimmed"

#specifies the directory where fastq_screen results will be saved
FASTQSCREEN_DIR="transcriptomic-final-exercise/Apartado1/output/fastqscreen"
mkdir -p "$FASTQSCREEN_DIR"

#in the fastqscreen folder to obtain the reference genomes.
#fastqscreen --get_genomes 

#specifies the path to the fastq_screen database you want to use, in this case all of them
DATABASE="transcriptomic-final-exercise/Apartado1/output/fastqscreen/FastQ_Screen_Genomes/fastq_screen.conf"

#iteration over each pair of fastq files in the directory FASTQ_DIR
for file in $FASTQ_DIR/*_1.trimmed.fastq
do
    #get the name of the read 1 file and delete the part "_1.trimmed.fastq"
    filename=$(basename "$file")
    sample_name=${filename%%_1.trimmed.fastq}

    #run fastq_screen
    fastq_screen --paired --outdir "$FASTQSCREEN_DIR" --aligner bowtie2 \
        --threads 8 --conf "$DATABASE" \
        "$FASTQ_DIR/${sample_name}_1.trimmed.fastq" "$FASTQ_DIR/${sample_name}_2.trimmed.fastq"
done

