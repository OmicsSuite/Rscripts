# Author: Benben Miao
# Email: benben.miao@outlook.com
# Rversion: 4.2.0
# Date: 2022-11-30

# -> 0. Install and Library
# install.packages(c("ggplot2", "ggsci"))
# BiocManager::install("maftools")
library(ggplot2)
library(ggsci)
library(maftools)
# <- 0. Install and Library

options(warn = -1)

# -> 1. File Read
# laml.maf = system.file('extdata', 'tcga_laml.maf.gz', package = 'maftools')
file_path = "data/MafSummary/tcga_laml.maf.gz"
maf_data = read.maf(maf = file_path,
				clinicalData = NULL,
				rmFlags = FALSE,
				removeDuplicatedVariants = TRUE,
				useAll = TRUE,
				gisticAllLesionsFile = NULL,
				gisticAmpGenesFile = NULL,
				gisticDelGenesFile = NULL,
				gisticScoresFile = NULL,
				cnLevel = "all",
				cnTable = NULL,
				isTCGA = FALSE,
				vc_nonSyn = NULL,
				verbose = FALSE
				)

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
# 					   stringsAsFactors = F
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
# set.seed(123)
# df <- data.frame(x = rnorm(200), y = rnorm(200))
# write.table(df, "DensityContour.txt", quote = F, sep = "\t", row.names = F)
# <- 2. Data Operation

# -> 3. Plot Parameters
fonts <- "Times"
# ChoiceBox: "Times", "Palatino", "Bookman", "Courier", "Helvetica", "URWGothic", "NimbusMon", "NimbusSan"

ggTheme <- "theme_default"
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

sciPalAlpha <- 1.00
# Slider: 0.5, 0, 0.1, 1.0
sciPal <- "Sci_AAAS"
# ChoiceBox: "Sci_AAAS", "Sci_NPG", "Sci_Simpsons", "Sci_JAMA", "Sci_GSEA", "Sci_Lancet", "Sci_Futurama", "Sci_JCO", "Sci_NEJM", "Sci_IGV", "Sci_UCSC", "Sci_D3", "Sci_Material"
if (sciPal == "Sci_AAAS"){
	sci_pal <- pal_aaas(palette = c("default"), alpha = sciPalAlpha)(10)
	# Science and Science Translational Medicine:
	# "#3B4992FF" "#EE0000FF" "#008B45FF" "#631879FF" "#008280FF" "#BB0021FF" "#5F559BFF" "#A20056FF" "#808180FF" "#1B1919FF"
} else if (sciPal == "Sci_NPG") {
	sci_pal <- pal_npg(palette = "nrc", alpha = sciPalAlpha)(10)
} else if (sciPal == "Sci_Simpsons") {
	sci_pal <- pal_simpsons(palette = "springfield", alpha = sciPalAlpha)(16)
	# The Simpsons
} else if (sciPal == "Sci_JAMA") {
	sci_pal <- pal_jama(palette = c("default"), alpha = sciPalAlpha)(8)
	# The Journal of the American Medical Association
	# "#374E55FF" "#DF8F44FF" "#00A1D5FF" "#B24745FF" "#79AF97FF" "#6A6599FF" "#80796BFF"
} else if (sciPal == "Sci_GSEA") {
	sci_pal <- pal_gsea(palette = c("default"), alpha = sciPalAlpha, reverse = FALSE)(12)
	# GSEA GenePattern
	# "#4500ACFF" "#2600D1FF" "#6B58EEFF" "#8787FFFF" "#C6C0FFFF" "#D4D4FFFF" "#FFBFE5FF" "#FF8888FF" "#FF707FFF" "#FF5959FF" "#EE3F3FFF" "#D60C00FF"
} else if (sciPal == "Sci_Lancet") {
	sci_pal <- pal_lancet(palette = c("lanonc"), alpha = sciPalAlpha)(9)
	#  Lancet Oncology
	# "#00468BFF" "#ED0000FF" "#42B540FF" "#0099B4FF" "#925E9FFF" "#FDAF91FF" "#AD002AFF" "#ADB6B6FF" "#1B1919FF"
} else if (sciPal == "Sci_Futurama") {
	sci_pal <- pal_futurama(palette = c("planetexpress"), alpha = sciPalAlpha)(12)
	# Futurama
	# "#FF6F00FF" "#C71000FF" "#008EA0FF" "#8A4198FF" "#5A9599FF" "#FF6348FF" "#84D7E1FF" "#FF95A8FF" "#3D3B25FF" "#ADE2D0FF" "#1A5354FF" "#3F4041FF"
} else if (sciPal == "Sci_JCO") {
	sci_pal <- pal_jco(palette = c("default"), alpha = sciPalAlpha)(10)
	# Journal of Clinical Oncology:
	# "#0073C2FF" "#EFC000FF" "#868686FF" "#CD534CFF" "#7AA6DCFF" "#003C67FF" "#8F7700FF" "#3B3B3BFF" "#A73030FF" "#4A6990FF"
} else if (sciPal == "Sci_NEJM") {
	sci_pal <- pal_nejm(palette = c("default"), alpha = sciPalAlpha)(8)
	# The New England Journal of Medicine
} else if (sciPal == "Sci_IGV") {
	sci_pal <- pal_igv(palette = c("default", "alternating"), alpha = sciPalAlpha)(51)
	# Integrative Genomics Viewer (IGV)
} else if (sciPal == "Sci_UCSC") {
	sci_pal <- pal_ucscgb(palette = "default", alpha = sciPalAlpha)(26)
	# UCSC Genome Browser chromosome sci_pal
} else if (sciPal == "Sci_D3") {
	sci_pal <- pal_d3(palette = "category20",alpha = sciPalAlpha)(20)
	# D3.JS
} else if (sciPal == "Sci_Material") {
	sci_pal <- pal_material(palette = "orange", n = 100, alpha = sciPalAlpha, reverse = FALSE)(100)
	# The Material Design color palettes
}

title <- "Title"
# TextField

xlab <- "X Label"
ylab <- "Y Label"
# ==========

isDashboard <- "Dashboard_Yes"
# ChoiceBox: "Dashboard_Yes", "Dashboard_No"
if (isDashboard == "Dashboard_Yes") {
	dashboard <- TRUE
} else if (isDashboard == "Dashboard_No") {
	dashboard <- FALSE
}

titvShow <- "Titv_Show"
# ChoiceBox: "Titv_Show", "Titv_Hidden"
if (titvShow == "Titv_Show") {
	titvRaw <- TRUE
} else if (titvShow == "Titv_Hidden") {
	titvRaw <- FALSE
}

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
# plotmafSummary(maf = maf_data,
# 				rmOutlier = TRUE,
# 				dashboard = TRUE,
# 				titvRaw = TRUE,
# 				log_scale = FALSE,
# 				addStat = "median",
# 				showBarcodes = FALSE,
# 				fs = 1,
# 				textSize = 0.8,
# 				color = NULL,
# 				titleSize = c(1, 0.8),
# 				titvColor = NULL,
# 				top = 10
# 				)
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
plotmafSummary(maf = maf_data,
			   rmOutlier = TRUE,
			   dashboard = dashboard,
			   titvRaw = titvRaw,
			   log_scale = FALSE,
			   addStat = "median",
			   showBarcodes = FALSE,
			   fs = 1,
			   textSize = 0.8,
			   color = NULL,
			   titleSize = c(1, 0.8),
			   titvColor = NULL,
			   top = 10
)
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
plotmafSummary(maf = maf_data,
			   rmOutlier = TRUE,
			   dashboard = dashboard,
			   titvRaw = titvRaw,
			   log_scale = FALSE,
			   addStat = "median",
			   showBarcodes = FALSE,
			   fs = 1,
			   textSize = 0.8,
			   color = NULL,
			   titleSize = c(1, 0.8),
			   titvColor = NULL,
			   top = 10
)
dev.off()
# <- 7. JPEG