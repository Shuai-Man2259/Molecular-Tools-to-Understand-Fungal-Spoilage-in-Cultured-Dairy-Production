#!/bin/bash

# Load or activate khmer environment if using a module system or conda
# module load khmer or conda activate your_khmer_environment

# Directory containing the raw FASTQ files
input_dir="/home/snyderlab/Mucor/raw"
# Output directory for normalized reads
output_dir="/home/snyderlab/Mucor/raw/normalized_reads"

# Create output directory if it doesn't exist
mkdir -p $output_dir

# Iterate over all R1 FASTQ files and find the corresponding R2 file
for r1_file in $input_dir/*_R1.fastq.gz; do
    # Generate the corresponding R2 file name
    r2_file="${r1_file/_R1/_R2}"

    # Base name without path and extension
    base_name=$(basename "$r1_file" _R1.fastq.gz)

    # Output file names
    norm_r1_out="${output_dir}/${base_name}_R1_norm.fastq.gz"
    norm_r2_out="${output_dir}/${base_name}_R2_norm.fastq.gz"

    # Run digital normalization
    normalize-by-median.py -k 20 -C 20 -M 4e9 \
        -p -o $norm_r1_out $r1_file $r2_file

    normalize-by-median.py -k 20 -C 20 -M 4e9 \
        -o $norm_r2_out $r1_file $r2_file
done

echo "Digital normalization complete. Normalized reads are in $output_dir"




export Bowtie2Align_ExtraParams="--reorder -X 1000"
export SamtoolsSamFilter_ExtraParams="-F 4 -q 30"
cat sampleFullPathNames.txt | xargs -n 2 -L 1 cfsan_snp_pipeline map_reads --threads $numCores reference/lambda_virus.fasta


export Bowtie2Align_ExtraParams="--reorder -X 1000"
export SamtoolsSamFilter_ExtraParams="-F 4 -q 30"
cat sampleFullPathNames.txt | xargs -n 2 -L 1 cfsan_snp_pipeline map_reads --threads $numCores reference/Mucor.c.fasta


export Bowtie2Align_ExtraParams="--reorder -X 1000"
export SamtoolsSamFilter_ExtraParams="-F 4 -q 30"
cat sampleFullPathNames.txt | xargs -n 2 cfsan_snp_pipeline map_reads --threads $numCores reference/my_reference.fasta