# Author: Benben Miao
# Email: benben.miao@outlook.com
# Rversion: 4.2.0
# Date: 2022-11-30

# -> 0. Install and Library
# install.packages(c("ggplot2", "ggsci"))
# BiocManager::install("ropls")
library(ropls)
library(ggplot2)
library(ggsci)
# library("ggplotify")
# <- 0. Install and Library

options(warn = 1)

# -> 1. File Read
file_path = "data/PartialLeastSquares/SampleGroupMetabolism.txt"
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
# data(sacurine)
# write.table(sacurine$dataMatrix, "SampleGroupMetabolism.txt", quote = F, sep = "\t", row.names = T)
# write.table(sacurine$sampleMetadata, "SampleGroupMetabolism2.txt", quote = F, sep = "\t", row.names = T)

# data("NCI60")
# nci.mae <- NCI60[["mae"]]
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

sciFillAlpha <- 0.90
sciColorAlpha <- 0.80
sciFillColor <- "Sci_AAAS"
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

title <- "Score PLS-DA"
# TextField

# xlab <- colnames(data)[1]
# ylab <- colnames(data)[2]
# ==========

algorithm <- "default"
# ChoiceBox: "default", "nipals", "svd"

sclaeData <- "standard"
# ChoiceBox: "none", "center", "pareto", "standard"

pointSize <- 5.0
# Slider: 5.0, 0.0, 30.0, 0.1

labelSize <- 3.0
# Slider: 3.0, 0.0, 30.0, 0.1

labelAlpha <- 0.80
# Slider: 0.80, 0.00, 1.00, 0.01

labelVjust <- 2.0
# Slider: 2.0, 0.0, 10.0, 0.1

labelHjust <- 0.5
# Slider: 0.5, 0.0, 1.0, 0.1

ellipseAlpha <- 0.20
# Slider: 0.20, 0.00, 1.00, 0.01

ellipseCI <- 0.95
# Slider: 0.95, 0.00, 1.00, 0.01

annotateSize <- 4.0
# Slider: 3.0, 0.0, 30.0, 0.1

annotateColor <- "#333333"
# ColorPicker

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
rownames(data) <- data[,1]

pls_result <- opls(as.matrix(data[,-c(1,2)]),
				   data[,2],
				   predI = NA,
				   orthoI = 0, # 0, 1
				   algoC = algorithm, # "default", "nipals", "svd"
				   crossvalI = 7,
				   log10L = FALSE,
				   permI = 20,
				   scaleC = sclaeData, # "none", "center", "pareto", "standard"
				   subset = NULL,
				   plotSubC = NA,
				   fig.pdfC = "none", # "none", "interactive", "myfile.pdf"
				   info.txtC = "none" # "none", "interactive", "myfile.txt"
)

# p <- plot(x = pls_result,
# 		typeVc = "x-score", # "correlation", "outlier", "overview", "permutation", "predict-train", "predict-test", "summary", "x-loading", "x-score", "x-variance", "xy-score", "xy-weight"
# 		parAsColFcVn = NA,
# 		parCexN = 0.7,
# 		parCompVi = c(1, 2),
# 		parEllipsesL = TRUE,
# 		parLabVc = NA,
# 		parPaletteVc = sci_pal,
# 		parTitleL = TRUE,
# 		parCexMetricN = NA,
# 		plotSubC = "",
# 		# fig.pdfC = "interactive", # "none", "interactive", "myfile.pdf"
# 		info.txtC = "none" # "none", "interactive", "myfile.txt"
# 	)



# pls_result@scoreMN
# pls_result@loadingMN

data2 <- pls_result@scoreMN
data2 <- as.data.frame(data2)
data2$Group <- data[,2]

p <- ggplot(data2,
			aes(x = p1,y = p2,
	   			color = data2[,length(data2)],
				shape = data2[,length(data2)],
	   			label = row.names(data2)
				)
			) +
	geom_point(size = pointSize
			   ) +
	geom_text(size = labelSize,
			  alpha = labelAlpha,
			  show.legend = FALSE,
			  vjust = labelVjust,
			  hjust = labelHjust
			  ) +
	stat_ellipse(aes(x = p1, y = p2,
					 fill = data2[,length(data2)]
					 ),
				 geom = "polygon",
				 alpha = ellipseAlpha,
				 level = ellipseCI,
				 show.legend = FALSE
	) +
	annotate("text",
			 x = max(pls_result@scoreMN[,1]) + ((max(pls_result@scoreMN[,1]) - min(pls_result@scoreMN[,1])) * 0.1),
			 y = max(pls_result@scoreMN[,2] + ((max(pls_result@scoreMN[,2]) - min(pls_result@scoreMN[,2])) * 0.2)),
			 parse = FALSE,
			 size = annotateSize,
			 label = paste('R2X:', pls_result@summaryDF$`R2X(cum)`),
			 colour = annotateColor,
			 hjust = 1,
			 fontface = "bold.italic"
			 	) +
	annotate("text",
			 x = max(pls_result@scoreMN[,1]) + ((max(pls_result@scoreMN[,1]) - min(pls_result@scoreMN[,1])) * 0.1),
			 y = max(pls_result@scoreMN[,2] + ((max(pls_result@scoreMN[,2]) - min(pls_result@scoreMN[,2])) * 0.1)),
			 parse = FALSE,
			 size = annotateSize,
			 label = paste('R2Y:', pls_result@summaryDF$`R2Y(cum)`),
			 colour = annotateColor,
			 hjust = 1,
			 fontface = "bold.italic"
	) +
	annotate("text",
			 x = max(pls_result@scoreMN[,1]) + ((max(pls_result@scoreMN[,1]) - min(pls_result@scoreMN[,1])) * 0.1),
			 y = max(pls_result@scoreMN[,2]),
			 parse = FALSE,
			 size = annotateSize,
			 label = paste('Q2:', pls_result@summaryDF$`Q2(cum)`),
			 colour = annotateColor,
			 hjust = 1,
			 fontface = "bold.italic"
	) +
	annotate("text",
			 x = max(pls_result@scoreMN[,1]) + ((max(pls_result@scoreMN[,1]) - min(pls_result@scoreMN[,1])) * 0.1),
			 y = max(pls_result@scoreMN[,2] - ((max(pls_result@scoreMN[,2]) - min(pls_result@scoreMN[,2])) * 0.1)),
			 parse = FALSE,
			 size = annotateSize,
			 label = paste('RMSEE:', pls_result@summaryDF$`RMSEE`),
			 colour = annotateColor,
			 hjust = 1,
			 fontface = "bold.italic"
	) +
	annotate("text",
			 x = max(pls_result@scoreMN[,1]) + ((max(pls_result@scoreMN[,1]) - min(pls_result@scoreMN[,1])) * 0.1),
			 y = max(pls_result@scoreMN[,2] - ((max(pls_result@scoreMN[,2]) - min(pls_result@scoreMN[,2])) * 0.2)),
			 parse = FALSE,
			 size = annotateSize,
			 label = paste('Pre:', pls_result@summaryDF$`pre`),
			 colour = annotateColor,
			 hjust = 1,
			 fontface = "bold.italic"
	) +
	annotate("text",
			 x = max(pls_result@scoreMN[,1]) + ((max(pls_result@scoreMN[,1]) - min(pls_result@scoreMN[,1])) * 0.1),
			 y = max(pls_result@scoreMN[,2] - ((max(pls_result@scoreMN[,2]) - min(pls_result@scoreMN[,2])) * 0.3)),
			 parse = FALSE,
			 size = annotateSize,
			 label = paste('pR2Y:', pls_result@summaryDF$`pR2Y`),
			 colour = annotateColor,
			 hjust = 1,
			 fontface = "bold.italic"
	) +
	annotate("text",
			 x = max(pls_result@scoreMN[,1]) + ((max(pls_result@scoreMN[,1]) - min(pls_result@scoreMN[,1])) * 0.1),
			 y = max(pls_result@scoreMN[,2] - ((max(pls_result@scoreMN[,2]) - min(pls_result@scoreMN[,2])) * 0.4)),
			 parse = FALSE,
			 size = annotateSize,
			 label = paste('pQ2:', pls_result@summaryDF$`pQ2`),
			 colour = annotateColor,
			 hjust = 1,
			 fontface = "bold.italic"
	) +
	labs(title = title,
		 x = paste("P1", " (", round(pls_result@modelDF$R2X[1], 2) * 100, "%)", sep = ""),
		 y = paste("P2", " (", round(pls_result@modelDF$R2X[2], 2) * 100, "%)", sep = ""),
		 shape = "Group",
		 color = "Group"
		 ) +
	sci_color +
	sci_fill +
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