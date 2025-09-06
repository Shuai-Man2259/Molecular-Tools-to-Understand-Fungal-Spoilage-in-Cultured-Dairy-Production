#!/bin/bash

# Ensure you are in the correct directory
cd /home/snyderlab/Mucor/raw

# Index the reference genome
bowtie2-build reference/Mucor.c.fasta reference/Mucor.c

# Loop over each R1 fastq file
for r1 in *_R1.fastq.gz; do
    # Determine the corresponding R2 file
    r2=${r1/_R1.fastq.gz/_R2.fastq.gz}

    # Ensure the R2 file exists
    if [[ -f "$r2" ]]; then
        echo "Processing pair: $r1 and $r2"
        
        # Run the SNP pipeline map_reads command
        cfsan_snp_pipeline map_reads --threads 112 reference/Mucor.c.fasta "$r1" "$r2"
    else
        echo "Warning: No matching R2 file for $r1"
    fi
done
