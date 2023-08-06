# Author: Benben Miao
# Email: benben.miao@outlook.com
# Rversion: 4.2.0
# Date: 2022-11-30

# -> 0. Install and Library
# install.packages(c("ggplot2", "ggsci"))
# BiocManager::install("pathview")
library(pathview)
library(magick)
# <- 0. Install and Library

options(warn = 1)

# -> 1. File Read
file_path = "data/PathwayData/PathwayNativeMultiSample.txt"
file_format = "txt"
# "xlsx", "xls", "txt", "csv"

if (file_format == "xlsx" | file_format == "xls") {
	data <- readxl::read_excel(path = file_path,
							   sheet = NULL,
							   col_names = TRUE,
							   na = "",
							   progress = readxl::readxl_progress()
	)
} else if (file_format == "txt" | file_format == "csv") {
	data <- read.table(file = file_path,
					   header = TRUE,
					   sep = "\t",
					   stringsAsFactors = F,
					   row.names = 1
	)
} else if (file_format == "csv") {
	data <- read.table(file = file_path,
					   header = TRUE,
					   sep = ",",
					   stringsAsFactors = F
	)
}
# <- 1. File Read

# -> 2. Data Operation
# data(gse16873.d)
# write.table(gse16873.d, file = "PathwayNative.txt", quote = F, sep = "\t", row.names = T)

# sim.cpd.data = sim.mol.data(mol.type = "cpd", # "gene", "gene.ko", "cpd"
# 							id.type = NULL, # "Entrez" and "KEGG COMPOUND accession"
# 							species = "hsa", # "hsa" (human), "mmu" (mouse)
# 							discrete = FALSE,
# 							nmol = 1000,
# 							nexp = 1,
# 							rand.seed = 2
# )
# write.table(sim.cpd.data, file = "CompoundsSingleSample.txt", quote = F, sep = "\t", row.names = T)
# <- 2. Data Operation

# -> 3. Plot Parameters
fonts <- "Times"
# ChoiceBox: "Times", "Palatino", "Bookman", "Courier", "Helvetica", "URWGothic", "NimbusMon", "NimbusSan"

# demo.paths$sel.paths[3]
pathwayID <- "00640"
# TextArea:

speciesAbbr <- "hsa"
# TextArea:

resultsPath <- "./test/"
# Temp:

# <- 3. Plot Parameters

# # -> 4. Plot
res <- pathview(gene.data = data,
				cpd.data = NULL,
				pathway.id = pathwayID,
				species = speciesAbbr,
				kegg.dir = resultsPath,
				cpd.idtype = "kegg",
				gene.idtype = "entrez",
				gene.annotpkg = NULL,
				min.nnodes = 3,
				kegg.native = FALSE,
				map.null = FALSE,
				expand.node = FALSE,
				split.group = TRUE,
				map.symbol = TRUE,
				map.cpdname = TRUE,
				node.sum = "sum",
				discrete = list(gene = FALSE, cpd = FALSE),
				limit = list(gene = 1, cpd = 1),
				bins = list(gene = 10, cpd = 10),
				both.dirs = list(gene = T, cpd = T),
				trans.fun = list(gene = NULL, cpd = NULL),
				low = list(gene = "green", cpd = "blue"),
				mid = list(gene = "gray", cpd = "gray"),
				high = list(gene = "red", cpd = "yellow"),
				na.col = "transparent"
)

image <- image_read_pdf(paste("./", speciesAbbr, pathwayID, ".pathview.multi.pdf", sep = ""),
						pages = NULL,
						density = 300,
						password = "")
# image2 <- image_convert(image,
# 						format = "png",
# 						type = NULL,
# 						colorspace = NULL,
# 						depth = NULL,
# 						antialias = NULL,
# 						matte = TRUE,
# 						interlace = NULL
# 					)
image_write(image,
			path = paste(resultsPath, speciesAbbr, pathwayID, ".pathview.multi.png", sep = ""),
			format = "png",
			quality = 100,
			depth = NULL,
			density = NULL,
			comment = NULL,
			flatten = FALSE,
			defines = NULL,
			compression = NULL
)

file.copy(from = paste("./", speciesAbbr, pathwayID, ".pathview.multi.pdf", sep = ""),
		  to = paste(resultsPath, speciesAbbr, pathwayID, ".pathview.multi.pdf", sep = ""),
		  overwrite = TRUE,
		  copy.mode = TRUE,
		  copy.date = TRUE)
file.remove(paste("./", speciesAbbr, pathwayID, ".pathview.multi.pdf", sep = ""))
# # <- 4. Plot
