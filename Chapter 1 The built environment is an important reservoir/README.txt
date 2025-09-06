README: Analysis Code for Chapter 1

Fungal Communities in Built Environment of Cultured Dairy Facilities
This repository contains the complete analysis code for Chapter 1 of the Master's thesis titled "From Environment to Product: Molecular Tools to Understand Fungal Spoilage in Cultured Dairy Production" by Shuai Man (Cornell University, 2024).

Chapter Overview
Title: The Built Environment of Cultured Dairy Plants Is an Important Reservoir of Yeasts and Molds

This chapter investigates:

1. Identification of fungi from the built environment and spoiled products2. Fungi on surfaces in cultured facilities were significantly different acrossproduction areas
3. Fungi from different types of swab sites were not significantly differentbecause the fungi within a swab site type was highly variable
4. The fungal diversity and composition in the built environment of cultureddairy facilities are significantly influenced by seasons

############################################################################################################################
Analysis Workflow
The code performs the following analytical steps:

Data Import and Processing

	Import QIIME2 artifacts
	Parse taxonomy strings
	Create phyloseq object

Data Filtering and Quality Control
	Remove low-abundance taxa
	Filter unclassified genera
	Exclude samples with zero reads

Beta Diversity Analysis
	PCoA ordination using Bray-Curtis dissimilarity
	Visualization by Season, Production Area, and Swab Site
	Statistical comparison of community differences

Taxonomic Composition Analysis
	Relative abundance calculations
	Identification of dominant genera
	Tornado plots of top 10 genera

Stacked Bar Plots
	Visualization of community composition
	Grouped by experimental factors
	Custom color schemes for genera

############################################################################################################################
SOFTWARE INFORMATION 

R (version 4.3.1 or higher)
RStudio (recommended)
QIIME 2 (2023.5) for initial sequence processing

R Packages
The analysis requires the following R packages:
Core: tidyverse, phyloseq, vegan, ggplot2
Bioinformatics: DECIPHER, DESeq2, ape
Visualization: scales, grid, gridExtra
Specialized: qiime2R, microbiome, microbiomeutilities

####################################################################################################################
SEQUENCE INFORMATION

ITS sequences from this study are openly available at the BioProject accession number PRJNA1123599 at https://www.ncbi.nlm.nih.gov/sra/PRJNA1123599 .  


####################################################################################################################
The research presented in this thesis is available through Cornell University's dissertation repository and was adapted for publication in the manuscript, "Reservoirs of spoilage fungi in the built environment of cultured dairy facilities vary by season and location."

Shuai Man (a), Sarah Daly(a), Xiaoxuan Shi(a), Jingzhang Feng(a), Abigail B. Snyder(a)
(a)Department of Food Science, Cornell University, Ithaca, NY


Contact information for Corresponding Authors 
*Abigail B. Snyder, Sarah E. Daly 
Department of Food Science, Cornell University, Ithaca, NY 14853, USA (abs276@cornell.edu, sed84@cornell.edu)  
