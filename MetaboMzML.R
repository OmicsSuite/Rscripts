# Author: Benben Miao
# Email: benben.miao@outlook.com
# Rversion: 4.2.0
# Date: 2022-11-30

Sys.setlocale("LC_ALL", "en_US.UTF-8")
options(warn = -1)

# -> 0. Install and Library
# getOption("repos")
# options(repos = c(CRAN = "https://cran.rstudio.com"))
# options(repos = c(CRAN="https://mirrors.tuna.tsinghua.edu.cn/CRAN/"))
# options(BioC_mirror = "https://mirrors.tuna.tsinghua.edu.cn/bioconductor")

# install.packages(c("ggplot2", "ggsci"))
# BiocManager::install(c("impute", "pcaMethods", "globaltest",
# 					   "GlobalAncova", "Rgraphviz", "preprocessCore",
# 					   "genefilter", "sva", "limma",
# 					   "KEGGgraph", "siggenes", "BiocParallel",
# 					   "MSnbase", "multtest", "RBGL",
# 					   "edgeR", "fgsea", "devtools", "crmn"), force = TRUE)
# remotes::install_github("xia-lab/MetaboAnalystR", build = TRUE,
# 						build_vignettes = F, build_manual = F)
library("MetaboAnalystR")
# remotes::install_github("xia-lab/OptiLCMS", build = TRUE,
# 						build_vignettes = FALSE, build_manual = FALSE)
# library(R.utils)
# <- 0. Install and Library

# -> 1. File Read
# qcPath <- "./data/Q2G2S8mzML/QCs/"
# samplePath <- "./data/Q2G2S8mzML/Samples/"
# sampleGroup <- "./data/Q2G2S8mzML/sample-group.txt"
#
# tempPath <- "./temp/"
#
# # for (item in list.files(qcPath)) {
# # 	gunzip(filename = paste(qcPath, item, sep = ""),
# # 		   ext = "gz", FUN = gzfile,
# # 		   destname = paste("./temp/QCs/", substr(item, 1, nchar(item)-3), sep = ""), overwrite = TRUE)
# # }
#
# dir.create(paste(tempPath, "QCs/", sep = ""))
# tempQCsPath <- paste(tempPath, "QCs/", sep = "")
# for (item in list.files(qcPath)) {
# 	unzip(zipfile = paste(qcPath, item, sep = ""), files = NULL, list = FALSE,
# 		  overwrite = TRUE, junkpaths = FALSE, exdir = tempQCsPath,
# 		  unzip = "internal", setTimes = FALSE)
# }
#
# dir.create(paste(tempPath, "Samples/", sep = ""))
# tempSamplesPath <- paste(tempPath, "Samples/", sep = "")
# for (item in list.files(samplePath)) {
# 	unzip(zipfile = paste(samplePath, item, sep = ""), files = NULL, list = FALSE,
# 		  overwrite = TRUE, junkpaths = FALSE, exdir = tempSamplesPath,
# 		  unzip = "internal", setTimes = FALSE)
# }
#
# file.copy(sampleGroup, tempPath)

mzMLzipPath <- "./data/Q2G2S8mzML/QCs/QC_PREFA02.zip"
# TextArea:

file_name <- substr(strsplit(mzMLzipPath, split = "/")[[1]][length(strsplit(mzMLzipPath, split = "/")[[1]])],
	   1, nchar(strsplit(mzMLzipPath, split = "/")[[1]][length(strsplit(mzMLzipPath, split = "/")[[1]])]) - 4)

tempPath <- "./temp/"
filePath <- paste(tempPath, file_name, ".mzML", sep = "")

unzip(zipfile = mzMLzipPath, files = NULL, list = FALSE,
	  overwrite = TRUE, junkpaths = FALSE, exdir = tempPath,
	  unzip = "internal", setTimes = FALSE)
# <- 1. File Read

# -> 2. Data Operation
# set.seed(123)
# wdata = data.frame(
#     sex = factor(rep(c("F", "M"), each=200)),
#     weight = c(rnorm(200, 55), rnorm(200, 58)))
# <- 2. Data Operation

# -> 3. Plot Parameters
# fonts <- "Times"
# # ChoiceBox: "Times", "Palatino", "Bookman", "Courier", "Helvetica", "URWGothic", "NimbusMon", "NimbusSan"

dimPlot <- "2D"
# ChoiceBox: "3D", "2D"

resMZ <- "100"
# TextArea:
# <- 3. Plot Parameters

# # -> 4. Plot
plot <- function(){
	p <- PerformDataInspect(filePath,
					   dimension = dimPlot,
					   res = as.numeric(resMZ))
}
# # <- 4. Plot

# -> 5. Save parameters
pdf_name <- "results.pdf"
jpeg_name <- "results.jpeg"
width <- 10.00
height <- 6.18
units <- "in"
# font <- fonts
# <- 5. Save parameters

# -> 6. PDF
pdf(file = pdf_name,
	width = width,
	height = height
	# family = font
)
plot()
dev.off()
# <- 6. PDF

# -> 7. JPEG
jpeg(filename = jpeg_name,
	 width = width,
	 height = height,
	 units = units,
	 res = 300,
	 quality = 100
	 # family = font
)
plot()
dev.off()
# <- 7. JPEG