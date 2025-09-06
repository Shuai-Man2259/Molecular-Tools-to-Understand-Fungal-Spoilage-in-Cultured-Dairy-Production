Whole Genome Sequencing Analysis Pipeline for Mucor Species

Overview
This folder contains a comprehensive bioinformatics pipeline for processing whole genome sequencing (WGS) data of Mucor species, specifically focused on Mucor circinelloides. The pipeline processes raw sequencing reads through quality control, assembly, alignment, variant calling, and phylogenetic analysis.

Pipeline Workflow
The analysis follows this sequential workflow:

Quality Control & Trimming → 2. Read Normalization → 3. Genome Assembly → 4. Alignment to Reference → 5. Variant Calling → 6. Phylogenetic Analysis

Scripts and Their Functions
1. Quality Control and Trimming
	analyze_fastqc.py
	Purpose: Parse FastQC results to identify samples needing trimming


	check_fastqc.sh
	Purpose: Check FastQC results for warnings/failures in key metrics

	run_trimmomatic.sh
	Purpose: Perform quality trimming of reads


2. Read Normalization
	run_digital_normalization.sh
	Purpose: Digitally normalize reads to reduce redundancy

	merging.sh
	Purpose: Merge overlapping paired-end reads


3. Genome Assembly
	run_spades.sh / assembly.sh
	Purpose: De novo genome assembly using SPAdes


4. Alignment to Reference
	minimap.sh
	Purpose: Align assemblies to reference genome


5. Variant Calling and SNP Analysis
	run_snp_pipeline.sh
	Purpose: Identify SNPs using CFSAN SNP Pipeline

############################################################################################################################


Directory Structure
text
Mucor_WGS_Analysis/
├── raw/                          # Raw sequencing data
│   ├── FASTQ_files/              # Original FASTQ files
│   └── zip/                      # FastQC zip files
├── reference/                    # Reference genomes
│   └── Muco_sp_1006Ph_genomic.fasta
├── processed/                    # Processed data
│   ├── trimmed_reads/            # After Trimmomatic
│   ├── normalized_reads/         # After digital normalization
│   ├── merged_reads/             # After FLASH merging
│   ├── assemblies/               # SPAdes output
│   └── alignments/               # Alignment files
├── results/                      # Final results
│   ├── quality_reports/          # FastQC reports
│   ├── variant_calls/            # SNP calls
│   └── phylogenetic_trees/       # Phylogenetic trees
└── scripts/                      # All analysis scripts
