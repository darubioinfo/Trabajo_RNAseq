#!/bin/bash

mkdir -p transcriptomic-final-exercise/Apartado1/output/stadistic

for file in transcriptomic-final-exercise/Apartado1/output/sam_sample/SRR479052.sam transcriptomic-final-exercise/Apartado1/output/sam_sample/SRR479054.sam
do
    echo "Archivo: ${file}"
    base=$(basename ${file})
    samtools flagstat ${file} > transcriptomic-final-exercise/Apartado1/output/stadistic/${base}.flagstat.txt
    samtools stats ${file} > transcriptomic-final-exercise/Apartado1/output/stadistic/${base}.stats.tsv
done


