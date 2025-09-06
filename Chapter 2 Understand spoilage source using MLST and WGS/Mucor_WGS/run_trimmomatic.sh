#!/bin/bash

# Define paths to Trimmomatic and adapter files
TRIMMOMATIC_JAR="/programs/trimmomatic/trimmomatic-0.39.jar"
ADAPTERS="/programs/trimmomatic/adapters/TruSeq3-PE-2.fa"

# Loop through all paired-end FastQ files and run Trimmomatic
for R1 in Mucor_WGS_*_R1.fastq.gz; do
  R2=${R1/_R1/_R2}
  
  # Define output file names
  BASE=$(basename $R1 _R1.fastq.gz)
  PAIRED_R1=${BASE}_R1_paired.fastq.gz
  UNPAIRED_R1=${BASE}_R1_unpaired.fastq.gz
  PAIRED_R2=${BASE}_R2_paired.fastq.gz
  UNPAIRED_R2=${BASE}_R2_unpaired.fastq.gz
  
  # Run Trimmomatic in palindrome mode
  java -jar $TRIMMOMATIC_JAR PE -phred33 \
    $R1 $R2 \
    $PAIRED_R1 $UNPAIRED_R1 \
    $PAIRED_R2 $UNPAIRED_R2 \
    ILLUMINACLIP:$ADAPTERS:2:30:10 \
    LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
done
