# Author: Benben Miao
# Email: benben.miao@outlook.com
# Rversion: 4.2.2
# Date: 2023-02-13

# -> 0. Install and Library
# install.packages(c("ggplot2", "ggsci"))
# install.packages("dplyr")
# install.packages("Seurat")
# install.packages("patchwork")
library(dplyr)
library(Seurat)
library(patchwork)
library(ggplot2)
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
# pbmc.data <- Read10X(data.dir = "data/SeuratMatrix/hg19/")
# pbmc.data[1:100, 1:100]
# write.table(pbmc.data[, ], file = "test.txt", quote = FALSE, sep = "\t", row.names = TRUE)
# pbmc <- CreateSeuratObject(counts = pbmc.data, project = "pbmc3k", min.cells = 3, min.features = 200)
# <- 2. Data Operation

# -> 3. Plot Parameters
cellrangeOutPath <- "./data/SeuratMatrix/"
# TextArea:

fonts <- "Times"
# ChoiceBox: "Times", "Palatino", "Bookman", "Courier", "Helvetica", "URWGothic", "NimbusMon", "NimbusSan"

minCells <- 3
# Slider: 3, 0, 100, 1

minFeatures <- 200
# Slider: 200, 0, 500, 1

mitGenePattern <- "^MT-"
# TextInput

# visStat <- "Count_Feature_Mit"
# # ChoiceBox: "Count_Only", "Count_Feature", "Count_Feature_Mit"

filterMinFeature <- 200
# Slider: 200, 0, 5000, 1

filterMaxFeature <- 2500
# Slider: 2500, 0, 5000, 1

filterMaxMit <- 5
# Slider: 5, 0, 100, 1

# <- 3. Plot Parameters

# # -> 4. Plot
# seurat_object <- CreateSeuratObject(counts = data,
# 									project = "SingleCellRNAseqExpressionMatrix",
# 									assay = "RNA",
# 									names.delim = "_",
# 									# names.field = NULL,
# 									min.cells = minCells, # 3
# 									min.features = minFeatures # 200
# )
seurat_object.data <- Read10X(data.dir = cellrangeOutPath)
# pbmc.data[1:100, 1:100]
# write.table(pbmc.data[, ], file = "test.txt", quote = FALSE, sep = "\t", row.names = TRUE)
seurat_object <- CreateSeuratObject(counts = seurat_object.data,
									project = "SingleCell-RNA",
									assay = "RNA",
									names.delim = "_",
									# names.field = NULL,
									min.cells = minCells, # 3
									min.features = minFeatures # 200
)
# seurat_object

seurat_object[["percent.mt"]] <- PercentageFeatureSet(object = seurat_object,
													  pattern = mitGenePattern)
# head(seurat_object@meta.data, 5)

# if (visStat == "Count_Only") {
# 	p <- VlnPlot(seurat_object,
# 				 features = c("nCount_RNA"),
# 				 ncol = 3)
# } else if (visStat == "Count_Feature") {
# 	p <- VlnPlot(seurat_object,
# 				 features = c("nCount_RNA", "nFeature_RNA"),
# 				 ncol = 3)
# } else if (visStat == "Count_Feature_Mit") {
# 	p <- VlnPlot(seurat_object,
# 				 features = c("nCount_RNA", "nFeature_RNA", "percent.mt"),
# 				 ncol = 3)
# }

# # seurat_object@meta.data
# write.table(seurat_object@meta.data,
# 			file = "MetaData.txt",
# 			quote = FALSE,
# 			sep = "\t",
# 			row.names = TRUE)


plot1 <- FeatureScatter(seurat_object, feature1 = "nCount_RNA", feature2 = "percent.mt")
plot2 <- FeatureScatter(seurat_object, feature1 = "nCount_RNA", feature2 = "nFeature_RNA")
plot <- plot1 + plot2

seurat_object <- subset(seurat_object,
						subset = nFeature_RNA > filterMinFeature & nFeature_RNA < filterMaxFeature & percent.mt < filterMaxMit)
saveRDS(seurat_object,
		file = "Results-QC-Filter.rds",
		ascii = FALSE,
		version = NULL,
		compress = TRUE,
		refhook = NULL
		)
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