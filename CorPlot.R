# Author: Benben Miao
# Email: benben.miao@outlook.com
# Rversion: 4.2.0
# Date: 2022-04-28

# -> 0. Install and Library
# install.packages("ggcorrplot")
# install.packages("readxl")
# install.packages('Cairo')

library(ggplot2)
library(ggcorrplot)
library(readxl)
# <- 0. Install and Library

# -> 1. File read
file_path = "data/CorPlot/Transcriptomics-Gene-Expression.txt"
# file_path = "./2009-2020-data.txt"
file_format = "txt"
# "xlsx", "xls", "txt", "csv"

if (file_format == "xlsx" | file_format == "xls") {
	data <- readxl::read_excel(path = file_path,
			sheet = NULL,
			col_names = TRUE,
			na = "",
			progress = readxl::readxl_progress())
} else if (file_format == "txt" | file_format == "csv") {
	data <- read.table(file = file_path,
			header = TRUE,
			sep = "\t",
			stringsAsFactors = F)
} else if (file_format == "csv") {
	data <- read.table(file = file_path,
			header = TRUE,
			sep = ",",
			stringsAsFactors = F)
}
# <- 1. File read

# -> 2. NA and Duplicated
data <- as.data.frame(data)
data <- data[!is.na(data[, 1]), ]
idx <- duplicated(data[, 1])
data[idx, 1] <- paste0(data[idx, 1], "--dup-", cumsum(idx)[idx])
rownames(data) <- data[, 1]
data <- data[, -1]
# <- 2. NA and Duplicated

# -> 3. Plot parameters
cor_method <- "pearson"
# "pearson", "spearman", "kendall"

corr <- round(cor(data, use = "na.or.complete", method = cor_method), 3)
write.table(corr,
			file = "Results_Corr.txt",
			quote = FALSE,
			sep = "\t",
			row.names = TRUE)

method <- "square"
# "circle", "square"

type <- "full"
# "upper", "low", "full"

lab <- TRUE
lab_size <- 3

color_low <- "blue"
color_mid <- "white"
color_high <- "red"

digits <- 3
# Slider: 3, 0, 1, 3

ggTheme <- "theme_light"
# ChoiceBox: "theme_default", "theme_bw", "theme_gray", "theme_light", "theme_linedraw", "theme_dark", "theme_minimal", "theme_classic", "theme_void"
if (ggTheme == "theme_default") {
	gg_theme <- theme()
} else if (ggTheme == "theme_bw") {
	gg_theme <- theme_bw()
} else if (ggTheme == "theme_gray") {
	gg_theme <- theme_gray()
} else if (ggTheme == "theme_light") {
	gg_theme <- theme_light()
} else if (ggTheme == "theme_linedraw") {
	gg_theme <- theme_linedraw()
} else if (ggTheme == "theme_dark") {
	gg_theme <- theme_dark()
} else if (ggTheme == "theme_minimal") {
	gg_theme <- theme_minimal()
} else if (ggTheme == "theme_classic") {
	gg_theme <- theme_classic()
} else if (ggTheme == "theme_void") {
	gg_theme <- theme_void()
} else if (ggTheme == "theme_test") {
	gg_theme <- theme_test()
}
# <- 3. Plot parameters

# -> 4. Plot
p <- ggcorrplot(corr,
				hc.method = "complete",
				method = method,
				# colors = c(color_low, color_mid, color_high),
				outline.col = "white",
				hc.order = TRUE,
				type = type,
				lab = lab,
				lab_size = lab_size,
				legend.title = "Correlation",
				ggtheme = gg_theme,
				digits = digits
		) +
	scale_fill_gradient2(low = color_low,
						 mid = color_mid,
						 high = color_high,
						 limits = c(min(corr), max(corr))
						 ) +
		theme(text = element_text(family = "Times")
		)
# p

# library(ComplexHeatmap)
# library(circlize)
# col_fun = colorRamp2(c(min(corr), 0, max(corr)),
# 					 c(color_low, color_mid, color_high))
# Heatmap(corr,
# 		name = "Corr",
# 		col = col_fun,
# 		cell_fun = function(j, i, x, y, width, height, fill) {
# 			grid.text(sprintf("%.1f", corr[i, j]),
# 					  x, y, gp = gpar(fontsize = 10))
# 		})
# <- 4. Plot

# -> 5. Save parameters
pdf_name = "results.pdf"
jpeg_name = "results.jpeg"
device_pdf = "pdf"
device_jpeg = "jpeg"
# "pdf", "jpeg", "tiff", "png", "bmp", "svg"
width = 9
height = 7
units = "in"
# "in", "cm", "mm", "px"
dpi <- 300
# <- 5. Save parameters

# -> 6. Save image
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
# <- 6. Save image