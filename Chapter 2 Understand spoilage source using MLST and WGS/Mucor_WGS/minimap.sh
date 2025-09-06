#!/bin/bash

# Set the number of threads for parallel processing
export OMP_NUM_THREADS=$(nproc)

# Paths and filenames
reference="/home/snyderlab/Mucor/reference/Muco_sp_1006Ph_genomic.fasta"
output_dir="/home/snyderlab/Mucor/Mucor_assembly_output/minimap_bam_output"
mkdir -p "$output_dir"

# List of all assemblies to align against the reference
assemblies=(
    "Mucor_WGS_A01_1_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_A01_1_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_A03_21_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_A04_31_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_A04_31_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_A05_39_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_A05_39_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_B01_4_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_B01_4_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_B02_12_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_B03_22_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_B03_22_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_B04_32_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_B04_32_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_B05_40_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_B05_40_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_C01_5_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_C01_5_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_C02_13_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_C02_13_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_C03_23_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_C03_23_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_C04_33_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_C04_33_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_C05_41_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_C05_41_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_D01_6_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_D01_6_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_D02_14_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_D02_14_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_D03_24_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_D03_24_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_D04_34_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_D04_34_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_D05_42_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_D05_42_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_E01_7_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_E01_7_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_E02_15_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_E02_15_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_E03_26_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_E03_26_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_E04_35_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_E04_35_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_E05_43_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_E05_43_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_F01_8_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_F01_8_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_F02_17_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_F02_17_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_F03_27_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_F03_27_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_F04_36_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_F04_36_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_F05_46_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_F05_46_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_G01_9_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_G01_9_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_G02_18_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_G02_18_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_G03_28_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_G03_28_10475491_22MKWLLT3_L1_R2_assembly.msh",
    "Mucor_WGS_G04_37_10475491_22MKWLLT3_L1_R1_assembly.msh",
    "Mucor_WGS_H05_48_10475491_22MKWLLT3_L1_R2_assembly.msh",
)

# Loop through each assembly and perform alignment
for assembly in "${assemblies[@]}"; do
    output_file="${output_dir}/$(basename "${assembly}" .msh).sam"
    
    # Run minimap2 alignment (example command)
    minimap2 -ax map-ont "$reference" "$assembly" > "$output_file"
    
    # Check if the command succeeded
    if [ $? -ne 0 ]; then
        echo "Error aligning $assembly"
    else
        echo "Alignment completed for $assembly"
    fi
done

echo "Minimap alignment completed for all samples."
    

