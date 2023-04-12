#!/bin/bash

# Path to input directory
samples_dir="transcriptomic-final-exercise/Apartado1/output/trimmed/"

# Path to output directory
sam_dir="transcriptomic-final-exercise/Apartado1/output/sam_sample"
mkdir -p "$sam_dir"

# Loop over all files in the input directory
for file in "$samples_dir"/*.fastq; do

  # Extract the sample name from the file name
  sample=$(basename "$(basename "$file" .chr21_1.trimmed.fastq)" .chr21_2.trimmed.fastq)

  # Run HISAT2 on the sample
  echo "Aligning sample $sample ..."
  hisat2 --seed 123 -k 1 --no-spliced-alignment --new-summary -p 4  \
	  -x transcriptomic-final-exercise/Apartado1/index_hisat2_chr21/index \
	  -1 "$samples_dir/$sample".chr21_1.trimmed.fastq \
	  -2 "$samples_dir/$sample".chr21_2.trimmed.fastq \
	  -S "$sam_dir/$sample.sam" \
	  --summary-file "$sam_dir/$sample.summary.txt"

done

