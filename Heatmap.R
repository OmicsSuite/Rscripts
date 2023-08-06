# Author: Benben Miao
# Email: benben.miao@outlook.com
# Rversion: 4.2.2
# Date: 2023-02-13

# -> 0. Install and Library
# install.packages(c("ggplot2", "ggsci"))
# install.packages("circlize")
# BiocManager::install("ComplexHeatmap")
library(circlize)
library(ComplexHeatmap)
library(ggplot2)
# <- 0. Install and Library

options(warn = 1)

# -> 1. File Read
file_path = "data/Heatmap/Heatmap.txt"
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
# set.seed(123)
# nr1 = 4; nr2 = 8; nr3 = 6; nr = nr1 + nr2 + nr3
# nc1 = 6; nc2 = 8; nc3 = 10; nc = nc1 + nc2 + nc3
# mat = cbind(rbind(matrix(rnorm(nr1*nc1, mean = 1,   sd = 0.5), nr = nr1),
# 				  matrix(rnorm(nr2*nc1, mean = 0,   sd = 0.5), nr = nr2),
# 				  matrix(rnorm(nr3*nc1, mean = 0,   sd = 0.5), nr = nr3)),
# 			rbind(matrix(rnorm(nr1*nc2, mean = 0,   sd = 0.5), nr = nr1),
# 				  matrix(rnorm(nr2*nc2, mean = 1,   sd = 0.5), nr = nr2),
# 				  matrix(rnorm(nr3*nc2, mean = 0,   sd = 0.5), nr = nr3)),
# 			rbind(matrix(rnorm(nr1*nc3, mean = 0.5, sd = 0.5), nr = nr1),
# 				  matrix(rnorm(nr2*nc3, mean = 0.5, sd = 0.5), nr = nr2),
# 				  matrix(rnorm(nr3*nc3, mean = 1,   sd = 0.5), nr = nr3))
# )
# mat = mat[sample(nr, nr), sample(nc, nc)] # random shuffle rows and columns
# rownames(mat) = paste0("row", seq_len(nr))
# colnames(mat) = paste0("column", seq_len(nc))
#
# small_mat = mat[1:9, 1:9]
#
# write.table(small_mat, file = "Heatmap.txt", quote = FALSE, sep = "\t", row.names = TRUE)
data <- as.matrix(data)
# <- 2. Data Operation

# -> 3. Plot Parameters
fonts <- "Times"
# ChoiceBox: "Times", "Palatino", "Bookman", "Courier", "Helvetica", "URWGothic", "NimbusMon", "NimbusSan"

lowColor <- "#008800"
	# ColorPicker

midColor <- "#ffffff"
	# ColorPicker

highColor <- "#0000ff"
	# ColorPicker

textSize <- 10
# Slider: 10, 0, 90, 1

clusterMethod <- "complete"
# ChoiceBox: "ward.D", "ward.D2", "single", "complete", "average", "mcquitty", "median", "centroid"

distanceMethod <- "euclidean"
# ChoiceBox: "euclidean", "maximum", "manhattan", "canberra", "binary", "minkowski"
# <- 3. Plot Parameters

# # -> 4. Plot
col_fun = colorRamp2(c(round(min(data)), 0, round(max(data))),
					 c(lowColor, midColor, highColor))

p1 <- Heatmap(data,
			col = col_fun,
			name = "ColorBar",
			na_col = "grey",
			color_space = "LAB",
			rect_gp = gpar(col = NA),
			border = NA,
			border_gp = gpar(col = "black"),
			cell_fun = function(j, i, x, y, width, height, fill) {
				grid.text(sprintf("%.1f", data[i, j]), x, y, gp = gpar(fontsize = textSize))
			},
			cluster_rows = TRUE,
			cluster_row_slices = TRUE,
			clustering_distance_rows = distanceMethod,
			clustering_method_rows = clusterMethod,
			row_dend_side = "left",
			row_dend_width = unit(20, "mm"),
			show_row_dend = TRUE,
			# row_dend_reorder = is.logical(cluster_rows) || is.function(cluster_rows),
			row_dend_gp = gpar(),
			cluster_columns = TRUE,
			cluster_column_slices = TRUE,
			clustering_distance_columns = distanceMethod,
			clustering_method_columns = clusterMethod,
			column_dend_side = "top",
			column_dend_height = unit(20, "mm"),
			show_column_dend = TRUE,
			column_dend_gp = gpar()
			# column_dend_reorder = is.logical(cluster_columns) || is.function(cluster_columns)
			)
# # <- 4. Plot

# -> 5. Save parameters
pdf_name <- "results.pdf"
jpeg_name <- "results.jpeg"
width <- 10.00
height <- 6.18
units <- "in"
font <- fonts
# <- 5. Save parameters

# -> 6. PDF
pdf(file = pdf_name,
	width = width,
	height = height,
	family = font
)
p <- plot(p1)
p
dev.off()
# <- 6. PDF

# -> 7. JPEG
jpeg(filename = jpeg_name,
	 width = width,
	 height = height,
	 units = units,
	 res = 300,
	 quality = 100,
	 family = font
)
p <- plot(p1)
p
dev.off()
# <- 7. JPEG