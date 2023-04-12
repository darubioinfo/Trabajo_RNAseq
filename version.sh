#!/bin/bash

RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
CYAN='\033[1;34m'
PURPLE='\033[0;35m'
GRAY='\033[1;30m'
NC='\033[0m'
echo -e "${RED}Versión de fastqc:${NC}"
fastqc -v

echo -e "${YELLOW}Versión de fastq-screen:${NC}"
fastq_screen -v

echo -e "${GRAY}Versión de fastp:${NC}"
fastp -v

echo -e "${GREEN}Versión de hisat2:${NC}"
hisat2 --version

echo -e "${PURPLE}Versión de samtools:${NC}"
samtools --version

echo -e "${CYAN}Versión de featureCounts:${NC}"
featureCounts -v

echo -e "${GRAY}Versión de multiqc:${NC}"
multiqc --version

