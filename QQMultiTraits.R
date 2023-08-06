# Author: Benben Miao
# Email: benben.miao@outlook.com
# Rversion: 4.2.0
# Date: 2022-11-30

# -> 0. Install and Library
# install.packages(c("ggplot2", "ggsci"))
# install.packages("CMplot")
# install.packages("plyr")
library("CMplot")
library(gtools)
# <- 0. Install and Library

options(warn = 1)

# -> 1. File Read
file_path = "data/TraitsSNP/TraitsSNP.txt"
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
# <- 1. File Read

# -> 2. Data Operation
# data(pig60K)
# write.table(pig60K, file = "SNP-Traits.txt", quote = F, sep = "\t", row.names = F)
# <- 2. Data Operation

# -> 3. Plot Parameters

fonts <- "Times"
# ChoiceBox: "Times", "Palatino", "Bookman", "Courier", "Helvetica", "URWGothic", "NimbusMon", "NimbusSan"

lowColor <- "#008800"
	# ColorPicker:

midColor <- "#F2CD5C"
	# ColorPicker:

highColor <- "#F55050"
	# ColorPicker:

chrLabelSize <- 1.00
# Slider: 1.00, 0.00, 10.00, 0.01

pointSize <- 1.00
# Slider: 1.00, 0.00, 10.00, 0.01

thresholdValue <- "1e-6"
# TextArea:

thresholdColor <- "#000088"
	# ColorPicker:

resultsPath <- "./test/"

# <- 3. Plot Parameters

# # -> 4. Plot

CMplot(data,
	   plot.type = "q",
	   col = c(lowColor, midColor, highColor),
	   cex.axis = chrLabelSize,
	   multracks = TRUE,
	   threshold = as.numeric(thresholdValue),
	   threshold.lty = 2,
	   threshold.col = thresholdColor,
	   amplify = FALSE,
	   signal.col = thresholdColor,
	   signal.cex = pointSize,
	   cex = pointSize,
	   conf.int = TRUE,
	   file.output = TRUE,
	   file = "jpg",
	   dpi = 300,
	   height = 6.18,
	   width = 10.00
)

CMplot(data,
	   plot.type = "q",
	   col = c(lowColor, midColor, highColor),
	   cex.axis = chrLabelSize,
	   multracks = TRUE,
	   threshold = as.numeric(thresholdValue),
	   threshold.lty = 2,
	   threshold.col = thresholdColor,
	   amplify = FALSE,
	   signal.col = thresholdColor,
	   signal.cex = pointSize,
	   cex = pointSize,
	   conf.int = TRUE,
	   file.output = TRUE,
	   file = "pdf",
	   dpi = 300,
	   height = 6.18,
	   width = 10.00
)
# # <- 4. Plot
MultraitsJPG <- list.files(path = "./",
						   pattern = "Multraits.*\\.jpg",
						   full.names = TRUE)
file.copy(from = MultraitsJPG,
		  to = paste(resultsPath, "MultiTraits.jpg", sep = ""),
		  overwrite = TRUE,
		  copy.mode = TRUE,
		  copy.date = TRUE)
file.remove(MultraitsJPG)

MultraitsPDF <- list.files(path = "./",
						   pattern = "Multraits.*\\.pdf",
						   full.names = TRUE)
file.copy(from = MultraitsPDF,
		  to = paste(resultsPath, "MultiTraits.pdf", sep = ""),
		  overwrite = TRUE,
		  copy.mode = TRUE,
		  copy.date = TRUE)
file.remove(MultraitsPDF)
# =====

# MultraitsJPG <- list.files(path = "./",
# 						   pattern = "Multraits.*\\.jpg",
# 						   full.names = TRUE)
# file.remove(MultraitsJPG)
#
# MultraitsPDF <- list.files(path = "./",
# 						   pattern = "Multraits.*\\.pdf",
# 						   full.names = TRUE)
# file.remove(MultraitsPDF)
# =====

# MultracksJPG <- list.files(path = "./",
# 						   pattern = "Multracks.*\\.jpg",
# 						   full.names = TRUE)
# file.copy(from = MultracksJPG,
# 		  to = paste(resultsPath, "MultiTracks.jpg", sep = ""),
# 		  overwrite = TRUE,
# 		  copy.mode = TRUE,
# 		  copy.date = TRUE)
# file.remove(MultracksJPG)
#
# MultracksPDF <- list.files(path = "./",
# 						   pattern = "Multracks.*\\.pdf",
# 						   full.names = TRUE)
# file.copy(from = MultracksPDF,
# 		  to = paste(resultsPath, "MultiTracks.pdf", sep = ""),
# 		  overwrite = TRUE,
# 		  copy.mode = TRUE,
# 		  copy.date = TRUE)
# file.remove(MultracksPDF)
# =====

MultracksJPG <- list.files(path = "./",
						   pattern = "Multracks.*\\.jpg",
						   full.names = TRUE)
file.remove(MultracksJPG)

MultracksPDF <- list.files(path = "./",
						   pattern = "Multracks.*\\.pdf",
						   full.names = TRUE)
file.remove(MultracksPDF)