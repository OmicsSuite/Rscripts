# Author: Benben Miao
# Email: benben.miao@outlook.com
# Rversion: 4.2.2
# Date: 2023-02-13

# -> 0. Install and Library
# install.packages(c("ggplot2", "ggsci"))
# BiocManager::install(c('BiocGenerics', 'DelayedArray', 'DelayedMatrixStats',
# 					   'limma', 'lme4', 'S4Vectors', 'SingleCellExperiment',
# 					   'SummarizedExperiment', 'batchelor', 'HDF5Array',
# 					   'terra', 'ggrastr'), force = TRUE)
# remotes::install_github("cole-trapnell-lab/monocle3", dependencies = TRUE)
library(monocle3)
library(ggplot2)
library(dplyr)
# <- 0. Install and Library

options(warn = 1)

# -> 1. File Read
# file_path = "data/SeuratMatrix/Cell1000xGene1000.txt"
# file_format = "txt"
# # "xlsx", "xls", "txt", "csv"
#
# if (file_format == "xlsx" | file_format == "xls") {
# 	data <- readxl::read_excel(path = file_path,
# 							   sheet = NULL,
# 							   col_names = TRUE,
# 							   na = "",
# 							   progress = readxl::readxl_progress()
# 	)
# } else if (file_format == "txt" | file_format == "csv") {
# 	data <- read.table(file = file_path,
# 					   header = TRUE,
# 					   sep = "\t",
# 					   stringsAsFactors = F,
# 					   row.names = 1
# 	)
# } else if (file_format == "csv") {
# 	data <- read.table(file = file_path,
# 					   header = TRUE,
# 					   sep = ",",
# 					   stringsAsFactors = F
# 	)
# }
# <- 1. File Read

# -> 2. Data Operation

# <- 2. Data Operation

# -> 3. Plot Parameters
fonts <- "Times"
# ChoiceBox: "Times", "Palatino", "Bookman", "Courier", "Helvetica", "URWGothic", "NimbusMon", "NimbusSan"

cellRangerMatrixPath <- "./data/CellRanger3Matrix/"
# TextArea:

numPCs <- 50
# Slider: 50, 2, 200, 1

normMethod <- "log"
# ChoiceBox: "log", "size_only"

# <- 3. Plot Parameters

# # -> 4. Plot
cds <- load_mm_data(mat_path = paste(cellRangerMatrixPath, "matrix.mtx.gz", sep = ""),
					feature_anno_path = paste(cellRangerMatrixPath, "features.tsv.gz", sep = ""),
					cell_anno_path = paste(cellRangerMatrixPath, "barcodes.tsv.gz", sep = "")
					)
cds <- preprocess_cds(cds,
					  method = "PCA", # "PCA", "LSI"
					  num_dim = numPCs,
					  norm_method = normMethod, # "log", "size_only", "none"
					  use_genes = NULL,
					  pseudo_count = NULL,
					  scaling = TRUE,
					  verbose = FALSE,
					  build_nn_index = FALSE,
					  nn_control = list()
					  )
plot <- plot_pc_variance_explained(cds) +
	geom_point(size = 3, color = "red", alpha = 0.80) +
	theme_light()
# # <- 4. Plot

# -> 5. Save parameters
pdf_name = "results.pdf"
jpeg_name = "results.jpeg"
device_pdf = "pdf"
device_jpeg = "jpeg"
# "pdf", "jpeg", "tiff", "png", "bmp", "svg"
width = 10.00
height = 6.18
units = "in"
# "in", "cm", "mm", "px"
dpi <- 300
# <- 5. Save parameters

# -> 6. Save image
ggsave(
	filename = pdf_name,
	plot = plot,
	device = device_pdf,
	path = NULL,
	scale = 1,
	width = width,
	height = height,
	units = units,
	dpi = dpi,
	limitsize = TRUE
)
ggsave(
	filename = jpeg_name,
	plot = plot,
	device = device_jpeg,
	path = NULL,
	scale = 1,
	width = width,
	height = height,
	units = units,
	dpi = dpi,
	limitsize = TRUE
)
# <- 6. Save image