#!/bin/bash

# Path to the annotation file
annotation_file="transcriptomic-final-exercise/Apartado1/input/Homo_sapiens.GRCh38.109.chr21.gtf"

# Path to the output directory
counts_dir="transcriptomic-final-exercise/Apartado1/output/counts"
mkdir -p "$counts_dir"

# Path to the sorted BAM files
bam_file1="transcriptomic-final-exercise/Apartado1/output/bam_sample/SRR479052.sorted.bam"
bam_file2="transcriptomic-final-exercise/Apartado1/output/bam_sample/SRR479054.sorted.bam"

# Run featureCounts
echo "Counting features for BAM file 1 ..."
featureCounts -p -T 4 -B --countReadPairs -t exon -g gene_id -a "$annotation_file" -o "$counts_dir/SRR479052_counts.tsv" "$bam_file1"

echo "Counting features for BAM file 2 ..."

featureCounts -p -T 4 -B --countReadPairs -t exon -g gene_id -a "$annotation_file" -o "$counts_dir/SRR479054_counts.tsv" "$bam_file2"


