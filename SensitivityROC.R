# Author: Benben Miao
# Email: benben.miao@outlook.com
# Rversion: 4.2.0
# Date: 2022-11-30

# -> 0. Install and Library
# install.packages(c("ggplot2", "ggsci"))
# remotes::install_github("cardiomoon/multipleROC")
library(ggplot2)
library(ggsci)
library(multipleROC)
# <- 0. Install and Library

options (warn = 1)

# -> 1. File Read
file_path = "data/SensitivityROC/SensitivityROC.txt"
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
# require(moonBook)
# df <- radial[,1:4]
# write.table(df, "SensitivityROC.txt", quote = F, sep = "\t", row.names = F)
# <- 2. Data Operation

# -> 3. Plot Parameters
fonts <- "Times"
# ChoiceBox: "Times", "Palatino", "Bookman", "Courier", "Helvetica", "URWGothic", "NimbusMon", "NimbusSan"

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

sciFillAlpha <- 0.70
sciColorAlpha <- 0.70
sciFillColor <- "Sci_NPG"
# ChoiceBox: "Sci_AAAS", "Sci_NPG", "Sci_Simpsons", "Sci_JAMA", "Sci_GSEA", "Sci_Lancet", "Sci_Futurama", "Sci_JCO", "Sci_NEJM", "Sci_IGV", "Sci_UCSC", "Sci_D3", "Sci_Material"
if (sciFillColor == "Default"){
	sci_fill <- NULL
	sci_color <- NULL
} else if (sciFillColor == "Sci_AAAS") {
	sci_fill <- scale_fill_aaas(alpha = sciFillAlpha)
	sci_color <- scale_color_aaas(alpha = sciColorAlpha)
	# Science and Science Translational Medicine:
} else if (sciFillColor == "Sci_NPG") {
	sci_fill <- scale_fill_npg(alpha = sciFillAlpha)
	sci_color <- scale_color_npg(alpha = sciColorAlpha)
} else if (sciFillColor == "Sci_Simpsons") {
	sci_fill <- scale_fill_simpsons(alpha = sciFillAlpha)
	sci_color <- scale_color_simpsons(alpha = sciColorAlpha)
	# The Simpsons
} else if (sciFillColor == "Sci_JAMA") {
	sci_fill <- scale_fill_jama(alpha = sciFillAlpha)
	sci_color <- scale_color_jama(alpha = sciColorAlpha)
	# The Journal of the American Medical Association
} else if (sciFillColor == "Sci_Lancet") {
	sci_fill <- scale_fill_lancet(alpha = sciFillAlpha)
	sci_color <- scale_color_lancet(alpha = sciColorAlpha)
	#  Lancet Oncology
} else if (sciFillColor == "Sci_Futurama") {
	sci_fill <- scale_fill_futurama(alpha = sciFillAlpha)
	sci_color <- scale_color_futurama(alpha = sciColorAlpha)
	# Futurama
} else if (sciFillColor == "Sci_JCO") {
	sci_fill <- scale_fill_jco(alpha = sciFillAlpha)
	sci_color <- scale_color_jco(alpha = sciColorAlpha)
	# Journal of Clinical Oncology:
} else if (sciFillColor == "Sci_NEJM") {
	sci_fill <- scale_fill_nejm(alpha = sciFillAlpha)
	sci_color <- scale_color_nejm(alpha = sciColorAlpha)
	# The New England Journal of Medicine
} else if (sciFillColor == "Sci_IGV") {
	sci_fill <- scale_fill_igv(alpha = sciFillAlpha)
	sci_color <- scale_color_igv(alpha = sciColorAlpha)
	# Integrative Genomics Viewer (IGV)
} else if (sciFillColor == "Sci_UCSC") {
	sci_fill <- scale_fill_ucscgb(alpha = sciFillAlpha)
	sci_color <- scale_color_ucscgb(alpha = sciColorAlpha)
	# UCSC Genome Browser chromosome sci_fill
} else if (sciFillColor == "Sci_D3") {
	sci_fill <- scale_fill_d3(alpha = sciFillAlpha)
	sci_color <- scale_color_d3(alpha = sciColorAlpha)
	# D3.JS
} else if (sciFillColor == "Sci_Material") {
	sci_fill <- scale_fill_material(alpha = sciFillAlpha)
	sci_color <- scale_color_material(alpha = sciColorAlpha)
	# The Material Design color palettes
}

title <- "Receiver Operating Characteristic Curve"
# TextField

xlab <- "Specificity"
ylab <- "Sensitivity"
# ==========

pointShow <- "Point_Show"
# ChoiceBox: "Point_Show", "Point_Hidden"
if (pointShow == "Point_Show") {
	show_points <- TRUE
} else if (pointShow == "Point_Hidden") {
	show_points <- FALSE
}

etaShow <- "Eta_Show"
# ChoiceBox: "Eta_Show", "Eta_Hidden"
if (etaShow == "Eta_Show") {
	show_eta <- TRUE
} else if (etaShow == "Eta_Hidden") {
	show_eta <- FALSE
}

sensShow <- "Sens_Show"
# ChoiceBox: "Sens_Show", "Sens_Hidden"
if (sensShow == "Sens_Show") {
	show_sens <- TRUE
} else if (sensShow == "Sens_Hidden") {
	show_sens <- FALSE
}

aucShow <- "AUC_Show"
# ChoiceBox: "AUC_Show", "AUC_Hidden"
if (aucShow == "AUC_Show") {
	show_auc <- TRUE
} else if (aucShow == "AUC_Hidden") {
	show_auc <- FALSE
}

isFacet <- "Facet_No"
# ChoiceBox: "Facet_Yes", "Facet_No"
if (isFacet == "Facet_Yes") {
	facet <- TRUE
} else if (isFacet == "Facet_No") {
	facet <- FALSE
}

lineWidth <- 1.00
# Slider: 1.00, 0.00, 10.00, 0.01

pointSize <- 2.00
# Slider: 2.00, 0.00, 10.00, 0.01

# ==========
plotTitleFace <- "bold"
# ChoiceBox: "plain", "italic", "bold", "bold.italic"

plotTitleSize <- 18
# Slider: 18, 0, 50, 1

plotTitleHjust <- 0.5
# Slider: 0.5, 0.0, 1.0, 0.1

axisTitleFace <- "plain"
# ChoiceBox: "plain", "italic", "bold", "bold.italic"

axisTitleSize <- 14
# Slider: 16, 0, 50, 1

axisTextSize <- 10
# Slider: 10, 0, 50, 1

legendTitleSize <- 12
# Slider: 12, 0, 50, 1

legendPosition <- "right"
# ChoiceBox: "none", "left", "right", "bottom", "top"

legendDirection <- "vertical"
# ChoiceBox: "horizontal", "vertical"
# <- 3. Plot Parameters

# # -> 4. Plot
p <- plot_ROC2(yvar = colnames(data)[1],
			   xvars = as.vector(colnames(data)[-1]),
			   dataname = "data",
			   show.points = show_points,
			   show.eta = show_eta,
			   show.sens = show_sens,
			   show.AUC = show_auc,
			   facet = facet
			   ) +
	geom_line(linewidth = lineWidth
			  # alpha = 0.50
			  ) +
	geom_point(shape = 16,
			   size = pointSize
			   # alpha = 0.50
			   ) +
	labs(title = title,
		 x = xlab,
		 y = ylab,
		 color = "Group"
		 ) +
	sci_color +
	gg_theme +
	theme(text = element_text(family = fonts),
		  plot.title = element_text(face = plotTitleFace,
		  						  # "plain", "italic", "bold", "bold.italic"
		  						  size = plotTitleSize,
		  						  hjust = plotTitleHjust
		  ),
		  axis.title = element_text(face = axisTitleFace,
		  						  # "plain", "italic", "bold", "bold.italic"
		  						  size = axisTitleSize
		  ),
		  axis.text = element_text(face = "plain",
		  						 size = axisTextSize
		  ),
		  legend.title = element_text(face = "plain",
		  							size = legendTitleSize
		  ),
		  legend.position = legendPosition,
		  # "none", "left", "right", "bottom", "top"
		  legend.direction = legendDirection
		  # "horizontal" or "vertical"
	)

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