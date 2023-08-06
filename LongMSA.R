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

msa_file = "data/MSA/MSA_DNA.fasta"
# <- 1. File Read

# -> 2. Data Operation
# protein_sequences <- system.file("extdata", "sample.fasta", package = "ggmsa")
# miRNA_sequences <- system.file("extdata", "seedSample.fa", package = "ggmsa")
# nt_sequences <- system.file("extdata", "LeaderRepeat_All.fa", package = "ggmsa")
# <- 2. Data Operation

# -> 3. Plot Parameters
fonts <- "TimesNewRoman"
# ChoiceBox: "helvetical", "mono", "DroidSansMono", "TimesNewRoman"

startPos <- "0"
# TextArea:

endPos <- "240"
# TextArea:

colorScheme <- "Chemistry_NT"
# ChoiceBox: "Chemistry_NT", "Shapely_NT", "Zappo_NT", "Taylor_NT", "Chemistry_AA", "Shapely_AA", "Zappo_AA", "Taylor_AA", "Clustal", "LETTER", "CN6"

consensusShow <- "Consensus_Hidden"
# ChoiceBox: "Consensus_Show", "Consensus_Hidden"
if (consensusShow == "Consensus_Show") {
	consensus_views <- TRUE
} else if (consensusShow == "Consensus_Hidden") {
	consensus_views <- FALSE
}

numWidth <- 60
# Slider: 60, 10, 1000, 10
# <- 3. Plot Parameters

# # -> 4. Plot
p <- ggmsa(msa_file,
		   start = as.numeric(startPos),
		   end = as.numeric(endPos),
		   font = fonts, # "helvetical", "mono", "DroidSansMono", "TimesNewRoman"
		   color = colorScheme, # "Chemistry_NT", "Shapely_NT", "Zappo_NT", "Taylor_NT", "Chemistry_AA", "Shapely_AA", "Zappo_AA", "Taylor_AA", "Clustal", "LETTER", "CN6"
		   custom_color = NULL,
		   char_width = 0.50,
		   none_bg = FALSE,
		   by_conservation = FALSE,
		   position_highlight = NULL,
		   seq_name = TRUE,
		   border = "#FFFFFF",
		   consensus_views = consensus_views,
		   use_dot = FALSE,
		   disagreement = FALSE,
		   ignore_gaps = FALSE,
		   ref = NULL,
		   show.legend = FALSE) +
	facet_msa(field = numWidth)

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