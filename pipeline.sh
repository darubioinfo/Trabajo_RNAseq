#!/bin/bash

#software download and versions
#mamba install -c bioconda fastqc fastq-screen fastp hisat2 samtools htseq
#pip install multiqc
#conda list
#conda env export > RNAseq_DavidRubio.yml
#bash version.sh

#define variables
fastq_path='transcriptomic-final-exercise/Apartado1/input/'
fastqc_path='transcriptomic-final-exercise/Apartado1/output/fastqc/'
index_path='transcriptomic-final-exercise/Apartado1/index_hisat2_chr21/index'
ref_genome='transcriptomic-final-exercise/Apartado1/input/Homo_sapiens.GRCh38.dna.chromosome.21.fa'
qc_trim_path='transcriptomic-final-exercise/Apartado1/output/fastqc_trimmed/'
output_dir='transcriptomic-final-exercise/Apartado1/output/trimmed'

#create folder for fastqc and index
mkdir -p "$fastqc_path"
mkdir -p transcriptomic-final-exercise/Apartado1/index_hisat2_chr21
mkdir -p "$qc_trim_path"

#FastQC quality control to raw data
for seq_fastq in $(find "$fastq_path" -name '*.fastq')
do
    fastqc "$seq_fastq" -o "$fastqc_path"
done

#check if the index exists inside the directory and if not create index
if [ "$(ls -A transcriptomic-final-exercise/Apartado1/index_hisat2_chr21)" ]; then
    echo -e "Index already built, skipping...\n"
else
    hisat2-build --seed 123 -p 8 "$ref_genome" "$index_path"
fi

#preprocessing
bash preproc.sh

#FastQC quality control to trimmed samples
for trim_fastq in $(find "$output_dir" -name '*.fastq')
do
    fastqc "$trim_fastq" -o "$qc_trim_path"
done

#contamination analysis with fastq_screen
bash screen.sh

#alignment with hisat2 software
bash align.sh

#sam to bam conversion, sorting and indexing
bash posproc.sh

#alignment statistics
bash stadistic.sh

#quantification of gene expression with featureCounts
bash featurecounts.sh

#multiqc
bash multiqc.sh

#debugging the count table
bash merged.sh

#remove sam samples and trimmed
bash remove.sh
