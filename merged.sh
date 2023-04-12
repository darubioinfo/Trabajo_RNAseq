#!/bin/bash

output_dir="transcriptomic-final-exercise/Apartado1/output"
counts_dir="$output_dir/counts"
merged_dir="$counts_dir/merged"
mkdir -p "$merged_dir"
cut -f1 "$counts_dir/SRR479052_counts.tsv" | tail -n +1 > "$merged_dir/common_column.txt"
tail -n +1 "$counts_dir/SRR479052_counts.tsv" > "$merged_dir/SRR479052_counts_no_header.tsv"
tail -n +1 "$counts_dir/SRR479054_counts.tsv" > "$merged_dir/SRR479054_counts_no_header.tsv"
paste "$merged_dir/common_column.txt" "$merged_dir/SRR479052_counts_no_header.tsv" "$merged_dir/SRR479054_counts_no_header.tsv" | cut -f1,8,15 > "$merged_dir/merged_counts.tsv"
