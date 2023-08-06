# Author: Benben Miao
# Email: benben.miao@outlook.com
# Rversion: 4.2.0
# Date: 2022-11-30

# -> 0. Install and Library
# install.packages(c("ggplot2", "ggsci"))
# install.packages("UpSetR")
library(UpSetR)
library(ggplot2)
library(ggplotify)
# <- 0. Install and Library

options(warn = 1)

# -> 1. File Read
file_path = "data/UpSet/UpSet.txt"
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
# movies <- read.csv(system.file("extdata", "movies.csv", package = "UpSetR"),
# 				   header = T, sep = ";")
# write.table(movies, file = "UpSes.txt", quote = F, sep = "\t", row.names = F)
# <- 2. Data Operation

# -> 3. Plot Parameters
fonts <- "Times"
# ChoiceBox: "Times", "Palatino", "Bookman", "Courier", "Helvetica", "URWGothic", "NimbusMon", "NimbusSan"

ylab <- "Intersection Size"
# TextArea:

xlab <- "Set Size"
# TextArea:

keepOrder <- "KeepOrder"
# ChoiceBox: "KeepOrder", "NewOrder"
if (keepOrder == "KeepOrder") {
	keep_order <- TRUE
} else if (keepOrder == "NewOrder") {
	keep_order <- FALSE
}

dotColor <- "#ff3300"
# ColorPicker:

statBarColor <- "#008833"
# ColorPicker:

setsBarColor <- "#008888"
# ColorPicker:

pointSize <- 2.00
# Slider: 2.00, 0.00, 10.00, 0.01

hightRatio <- 0.55
# Slider: 0.55, 0.00, 1.00, 0.01

statBarOrder <- "freq"
# ChoiceBox: "freq", "degree"

# <- 3. Plot Parameters

# # -> 4. Plot
plot <- as.ggplot(
	upset(data,
		  # nsets = 5,
		  # nintersects = 40,
		  sets = colnames(data),
		  keep.order = keep_order,
		  set.metadata = NULL,
		  intersections = NULL,
		  matrix.color = dotColor,
		  main.bar.color = statBarColor,
		  mainbar.y.label = ylab,
		  mainbar.y.max = NULL,
		  sets.bar.color = setsBarColor,
		  sets.x.label = xlab,
		  point.size = pointSize,
		  line.size = 0.5,
		  mb.ratio = c(hightRatio, 1 - hightRatio),
		  expression = NULL,
		  att.pos = NULL,
		  att.color = "#000000",
		  order.by = statBarOrder, # "freq", "degree"
		  decreasing = TRUE,
		  show.numbers = "yes",
		  number.angles = 0,
		  group.by = "degree",
		  cutoff = NULL,
		  queries = NULL,
		  query.legend = "none",
		  shade.color = "#dedede",
		  shade.alpha = 0.25,
		  matrix.dot.alpha = 0.5,
		  empty.intersections = NULL,
		  color.pal = 1,
		  boxplot.summary = NULL,
		  attribute.plots = NULL,
		  scale.intersections = "identity",
		  scale.sets = "identity",
		  text.scale = 1,
		  set_size.angles = 0,
		  set_size.show = FALSE,
		  set_size.numbers_size = NULL,
		  set_size.scale_max = NULL)
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