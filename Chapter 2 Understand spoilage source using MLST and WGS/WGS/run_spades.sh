#!/bin/bash

# Navigate to the directory containing the files
cd /home/snyderlab/Mucor/raw

# Create an output directory for the SPAdes results if it doesn't exist
mkdir -p spades_output

# Loop through each pair of FASTQ files and run SPAdes
for r1 in *_R1.fastq.gz; do
    r2=${r1/_R1.fastq.gz/_R2.fastq.gz}
    sample_name=$(basename $r1 _R1.fastq.gz)
    
    echo "Running SPAdes on $r1 and $r2"
    
    # Create a specific output directory for each sample
    spades_output_dir=spades_output/${sample_name}
    mkdir -p ${spades_output_dir}
    
    # Run SPAdes
    spades.py -1 $r1 -2 $r2 -o ${spades_output_dir}
done

echo "SPAdes assembly completed for all samples."
