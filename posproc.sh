#!/bin/bash

# Path to input directory containing SAM files
sam_dir="transcriptomic-final-exercise/Apartado1/output/sam_sample/"

# Path to output directory
bam_dir="transcriptomic-final-exercise/Apartado1/output/bam_sample/"
mkdir -p "$bam_dir"

# Convert SAM files to BAM files and sort them
for file in "$sam_dir"/*.sam; do
    # Extract the sample name from the file name
    sample=$(basename "$file" .sam)

    # Convert the SAM file to a sorted BAM file
    echo "Converting and sorting SAM file $sample ..."
    samtools view -@ 5 -bS "$file" | samtools sort -@ 5 -o "${bam_dir}/${sample}.sorted.bam"
    samtools index "${bam_dir}/${sample}.sorted.bam"
#    rm "$sam_dir/$sample.sam"
done



