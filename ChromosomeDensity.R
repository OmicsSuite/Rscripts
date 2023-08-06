# # Author: Benben Miao
# Email: benben.miao@outlook.com
# Rversion: 4.2.0
# Date: 2022-11-30

# -> 0. Install and Library
# install.packages(c("ggplot2", "ggsci"))
# install.packages('RIdeogram')
library(RIdeogram)
library(magick)
library(rsvg)
# <- 0. Install and Library

options(warn = 1)

# -> 1. File Read
file_path = "data/ChromosomeDensity/karyotype.txt"
file_path2 = "data/ChromosomeDensity/density.txt"
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
					   stringsAsFactors = F
	)
} else if (file_format == "csv") {
	data <- read.table(file = file_path,
					   header = TRUE,
					   sep = ",",
					   stringsAsFactors = F
	)
}

if (file_format == "xlsx" | file_format == "xls") {
	data2 <- readxl::read_excel(path = file_path2,
							   sheet = NULL,
							   col_names = TRUE,
							   na = "",
							   progress = readxl::readxl_progress()
	)
} else if (file_format == "txt" | file_format == "csv") {
	data2 <- read.table(file = file_path2,
					   header = TRUE,
					   sep = "\t",
					   stringsAsFactors = F
	)
} else if (file_format == "csv") {
	data2 <- read.table(file = file_path2,
					   header = TRUE,
					   sep = ",",
					   stringsAsFactors = F
	)
}
# <- 1. File Read

# -> 2. Data Operation
# data(human_karyotype, package="RIdeogram")
# head(human_karyotype)
# write.table(human_karyotype, file = "karyotype.txt", quote = F, row.names = F, sep = "\t")
#
# data(gene_density, package="RIdeogram")
# head(gene_density)
# write.table(gene_density, file = "density.txt", quote = F, row.names = F, sep = "\t")
# <- 2. Data Operation

# -> 3. Plot Parameters
lowColor <- "#005588"
# ColorPicker:

midColor <- "#ffdd00"
# ColorPicker:

highColor <- "#ff0000"
# ColorPicker:

resultsPath <- "./test/"
# Temp

# <- 3. Plot Parameters

# # -> 4. Plot
ideogram(karyotype = data,
		 overlaid = gene_density,
		 colorset1 = c(lowColor, midColor, highColor)
		 )

# convertSVG("chromosome.svg",
# 		   file = "chromosome",
# 		   device = "png",
# 		   # width = width,
# 		   # height = 1.00,
# 		   # dpi = dpi
# 		   )
# convertSVG("chromosome.svg",
# 		   file = "chromosome",
# 		   device = "pdf"
# 		   # width = width,
# 		   # height = height,
# 		   # dpi = dpi
# 		   )

# image <- image_read_svg(paste("./", "chromosome.svg", sep = ""),
# 						width = NULL,
# 						height = NULL)
# image <- image_background(image, color = "#ffffff", flatten = TRUE)
# image <- image_crop(image, "720x680")
# image_write(image,
# 			path = paste(resultsPath, "chromosome.jpeg", sep = ""),
# 			format = "jpeg",
# 			quality = 100,
# 			depth = NULL,
# 			density = NULL,
# 			comment = NULL,
# 			flatten = FALSE,
# 			defines = NULL,
# 			compression = NULL
# )
# image_write(image,
# 			path = paste(resultsPath, "chromosome.pdf", sep = ""),
# 			format = "pdf",
# 			quality = 100,
# 			depth = NULL,
# 			density = NULL,
# 			comment = NULL,
# 			flatten = FALSE,
# 			defines = NULL,
# 			compression = NULL
# )

rsvg_pdf("./chromosome.svg", "./chromosome.pdf",
		 width = 1080, height = 1080)
rsvg_png("./chromosome.svg", "./chromosome.png",
		 width = 1080, height = 1080)
# # <- 4. Plot

file.remove(paste("./", "chromosome.svg", sep = ""))
file.copy(from = paste("./", "chromosome.pdf", sep = ""),
		  to = paste(resultsPath, "chromosome.pdf", sep = ""),
		  overwrite = TRUE,
		  copy.mode = TRUE,
		  copy.date = TRUE)
file.remove(paste("./", "chromosome.pdf", sep = ""))
file.copy(from = paste("./", "chromosome.png", sep = ""),
		  to = paste(resultsPath, "chromosome.png", sep = ""),
		  overwrite = TRUE,
		  copy.mode = TRUE,
		  copy.date = TRUE)
file.remove(paste("./", "chromosome.png", sep = ""))