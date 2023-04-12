#!/bin/bash
adapter_seq="AGATCGGAAGAGCACACGTCTGAACTCCAGTCA"
adapter_seq_r2="AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT"
input_dir="transcriptomic-final-exercise/Apartado1/input"
output_dir="transcriptomic-final-exercise/Apartado1/output/trimmed"
fasqc_trimmed_dir="$output_dir/fasqc_trimmed"
mkdir -p "$output_dir"
mkdir -p "$fasqc_trimmed_dir/fastp"

# Iterar sobre cada muestra y ejecutar fastp
for r1 in "$input_dir"/*.chr21_1.fastq
do
    # Obtener el nombre base de la muestra sin la extensión
    sample=$(basename "$r1" .chr21_1.fastq)
    
    # Construir los nombres de archivo de entrada y salida para la muestra actual
    r2="$input_dir/${sample}.chr21_2.fastq"
    r1_trimmed="$output_dir/${sample}.chr21_1.trimmed.fastq"
    r2_trimmed="$output_dir/${sample}.chr21_2.trimmed.fastq"
    
    # Ejecutar fastp
    fastp -i "$r1" -I "$r2" -o "$r1_trimmed" -O "$r2_trimmed" \
        --adapter_sequence "$adapter_seq" \
        --adapter_sequence_r2 "$adapter_seq_r2" \
        --cut_mean_quality 20 \
        --cut_front \
        --cut_tail \
        --length_required 50 \
        --detect_adapter_for_pe \
        --thread 8 \
        --html "$fasqc_trimmed_dir/fastp/${sample}_fastp.html"
done
# Esperar a que todos los procesos finalicen
wait

echo "Procesamiento de las muestras completado."

