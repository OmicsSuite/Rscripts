# Author: Benben Miao
# Email: benben.miao@outlook.com
# Rversion: 4.2.0
# Date: 2022-11-30

# -> 0. Install and Library
# install.packages(c("ggplot2", "ggsci"))
# BiocManager::install("ggmsa")
library(ggplot2)
library(ggsci)
library(ggmsa)
# <- 0. Install and Library

options(warn = 1)

# -> 1. File Read
# msa_dna = "data/MSA/MSA_DNA.fasta"
# msa_rna = "data/MSA/MSA_miRNA.fasta"
# msa_aa = "data/MSA/MSA_AA.fasta"

msa_file = "data/BundleMSA/Gram-positive_AKL.fasta"
# <- 1. File Read

# -> 2. Data Operation
# protein_sequences <- system.file("extdata", "sample.fasta", package = "ggmsa")
# miRNA_sequences <- system.file("extdata", "seedSample.fa", package = "ggmsa")
# nt_sequences <- system.file("extdata", "LeaderRepeat_All.fa", package = "ggmsa")
# <- 2. Data Operation

# -> 3. Plot Parameters

bundleColor <- "#0088EE"
# ColorPicker
# <- 3. Plot Parameters

# # -> 4. Plot
p <- ggSeqBundle(
		msa_file,
		line_widch = 0.3,
		line_thickness = 0.3,
		line_high = 0,
		spline_shape = 0.3,
		size = 0.5,
		alpha = 0.2,
		bundle_color = bundleColor,
		lev_molecule = c("-", "A", "V", "L", "I", "P", "F", "W", "M", "G", "S", "T", "C",
						 "Y", "N", "Q", "D", "E", "K", "R", "H")
)
# # <- 4. Plot

# -> 5. Save parameters
pdf_name = "results.pdf"
jpeg_name = "results.jpeg"
device_pdf = "pdf"
device_jpeg = "jpeg"
# "pdf", "jpeg", "tiff", "png", "bmp", "svg"
width = 10.0
height = 6.18
units = "in"
# "in", "cm", "mm", "px"
dpi <- 300
# <- 5. Save parameters

# -> 6. Save Image
ggsave(
	filename = pdf_name,
	plot = p,
	device = device_pdf,
	path = NULL,
	scale = 1,
	width = width,
	height = height,
	units = units,
	dpi = 300,
	limitsize = TRUE
)
ggsave(
	filename = jpeg_name,
	plot = p,
	device = device_jpeg,
	path = NULL,
	scale = 1,
	width = width,
	height = height,
	units = units,
	dpi = 300,
	limitsize = TRUE
)
# <- 6. Save Image