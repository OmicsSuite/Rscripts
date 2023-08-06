# Author: Benben Miao
# Email: benben.miao@outlook.com
# Rversion: 4.2.0
# Date: 2022-11-30

# -> 0. Install and Library
# install.packages(c("ggplot2", "ggsci"))
# remotes::install_github("shuyuzheng/Chloroplot")
# BiocManager::install(c("genbankr","coRdon"))
# library(ggplot2)
# library(ggsci)
library(chloroplot)
library(dplyr)
# <- 0. Install and Library

options(warn = -1)

# -> 1. File Read
file_path = "data/ChloroplastGenome/EU549769.1.gb"
plot_table <- PlotTab(gbfile = file_path,
					  local.file = TRUE,
					  gc.window = 100
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

# ggTheme <- "theme_default"
# # ChoiceBox: "theme_default", "theme_bw", "theme_gray", "theme_light", "theme_linedraw", "theme_dark", "theme_minimal", "theme_classic", "theme_void"
# if (ggTheme == "theme_default") {
# 	gg_theme <- theme()
# } else if (ggTheme == "theme_bw") {
# 	gg_theme <- theme_bw()
# } else if (ggTheme == "theme_gray") {
# 	gg_theme <- theme_gray()
# } else if (ggTheme == "theme_light") {
# 	gg_theme <- theme_light()
# } else if (ggTheme == "theme_linedraw") {
# 	gg_theme <- theme_linedraw()
# } else if (ggTheme == "theme_dark") {
# 	gg_theme <- theme_dark()
# } else if (ggTheme == "theme_minimal") {
# 	gg_theme <- theme_minimal()
# } else if (ggTheme == "theme_classic") {
# 	gg_theme <- theme_classic()
# } else if (ggTheme == "theme_void") {
# 	gg_theme <- theme_void()
# } else if (ggTheme == "theme_test") {
# 	gg_theme <- theme_test()
# }

# sciFillAlpha <- 0.80
# sciColorAlpha <- 0.80
# sciFillColor <- "Sci_NPG"
# # ChoiceBox: "Sci_AAAS", "Sci_NPG", "Sci_Simpsons", "Sci_JAMA", "Sci_GSEA", "Sci_Lancet", "Sci_Futurama", "Sci_JCO", "Sci_NEJM", "Sci_IGV", "Sci_UCSC", "Sci_D3", "Sci_Material"
# if (sciFillColor == "Default") {
# 	sci_fill <- NULL
# 	sci_color <- NULL
# } else if (sciFillColor == "Sci_AAAS") {
# 	sci_fill <- scale_fill_aaas(alpha = sciFillAlpha)
# 	sci_color <- scale_color_aaas(alpha = sciColorAlpha)
# 	# Science and Science Translational Medicine:
# } else if (sciFillColor == "Sci_NPG") {
# 	sci_fill <- scale_fill_npg(alpha = sciFillAlpha)
# 	sci_color <- scale_color_npg(alpha = sciColorAlpha)
# } else if (sciFillColor == "Sci_Simpsons") {
# 	sci_fill <- scale_fill_simpsons(alpha = sciFillAlpha)
# 	sci_color <- scale_color_simpsons(alpha = sciColorAlpha)
# 	# The Simpsons
# } else if (sciFillColor == "Sci_JAMA") {
# 	sci_fill <- scale_fill_jama(alpha = sciFillAlpha)
# 	sci_color <- scale_color_jama(alpha = sciColorAlpha)
# 	# The Journal of the American Medical Association
# } else if (sciFillColor == "Sci_Lancet") {
# 	sci_fill <- scale_fill_lancet(alpha = sciFillAlpha)
# 	sci_color <- scale_color_lancet(alpha = sciColorAlpha)
# 	#  Lancet Oncology
# } else if (sciFillColor == "Sci_Futurama") {
# 	sci_fill <- scale_fill_futurama(alpha = sciFillAlpha)
# 	sci_color <- scale_color_futurama(alpha = sciColorAlpha)
# 	# Futurama
# } else if (sciFillColor == "Sci_JCO") {
# 	sci_fill <- scale_fill_jco(alpha = sciFillAlpha)
# 	sci_color <- scale_color_jco(alpha = sciColorAlpha)
# 	# Journal of Clinical Oncology:
# } else if (sciFillColor == "Sci_NEJM") {
# 	sci_fill <- scale_fill_nejm(alpha = sciFillAlpha)
# 	sci_color <- scale_color_nejm(alpha = sciColorAlpha)
# 	# The New England Journal of Medicine
# } else if (sciFillColor == "Sci_IGV") {
# 	sci_fill <- scale_fill_igv(alpha = sciFillAlpha)
# 	sci_color <- scale_color_igv(alpha = sciColorAlpha)
# 	# Integrative Genomics Viewer (IGV)
# } else if (sciFillColor == "Sci_UCSC") {
# 	sci_fill <- scale_fill_ucscgb(alpha = sciFillAlpha)
# 	sci_color <- scale_color_ucscgb(alpha = sciColorAlpha)
# 	# UCSC Genome Browser chromosome sci_fill
# } else if (sciFillColor == "Sci_D3") {
# 	sci_fill <- scale_fill_d3(alpha = sciFillAlpha)
# 	sci_color <- scale_color_d3(alpha = sciColorAlpha)
# 	# D3.JS
# } else if (sciFillColor == "Sci_Material") {
# 	sci_fill <- scale_fill_material(alpha = sciFillAlpha)
# 	sci_color <- scale_color_material(alpha = sciColorAlpha)
# 	# The Material Design color palettes
# }

# title <- "Density Contour"
# # TextField
#
# xlab <- colnames(data)[1]
# ylab <- colnames(data)[2]
# ==========

genes <- "psa,psb,pet,atp,ndh,rbc,rpo,rps,rpl,clp|mat|inf,ycf,trn,rrn,OTHER"
show_genes <- strsplit(genes, split = ",")[[1]]

shadowShow <- "Shadow_Show"
# ChoiceBox: "Shadow_Show", "Shadow_Hidden"
if (shadowShow == "Shadow_Show") {
	shadow <- TRUE
} else if (shadowShow == "Shadow_Hidden") {
	shadow <- FALSE
}

GCofIR <- "GCofIR_Show"
# ChoiceBox: "GCofIR_Show", "GCofIR_Hidden"
if (GCofIR == "GCofIR_Show") {
	ir_gc <- TRUE
} else if (GCofIR == "GCofIR_Hidden") {
	ir_gc <- FALSE
}

GCperGene <- "GCperGene_Show"
# ChoiceBox: "GCperGene_Show", "GCperGene_Hidden"
if (GCperGene == "GCperGene_Show") {
	gc_gene <- TRUE
} else if (GCperGene == "GCperGene_Hidden") {
	gc_gene <- FALSE
}

pseudoMark <- "PseudoMark_Yes"
# ChoiceBox: "PseudoMark_Yes", "PseudoMark_No"
if (pseudoMark == "PseudoMark_Yes") {
	pseudo_mark <- TRUE
} else if (pseudoMark == "PseudoMark_No") {
	pseudo_mark <- FALSE
}

indelHighlight <- "InDel_Highlight"
# ChoiceBox: "InDel_Highlight", "InDel_Normal"
if (indelHighlight == "InDel_Highlight") {
	indel_highlight <- TRUE
} else if (indelHighlight == "InDel_Normal") {
	indel_highlight <- FALSE
}

backgroundColor <- "#00880033"
# ColorPicker

GCbackground <- "#00880033"
# ColorPicker

infoBackground <- "#000000"
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
# PlotPlastidGenome(plot.tables = plot_table,
# 					   save = FALSE,
# 					   # # file.type = "pdf",
# 					   # text.size = 1,
# 					   height = c(0.1, 0.2, 0.07),
# 					   # file.name = NULL,
# 					   shadow = shadow,
# 					   ir.gc = ir_gc, # GCofIR
# 					   gc.per.gene = gc_gene,
# 					   pseudo = pseudo_mark,
# 					   legend = TRUE,
# 					   ssc.converse = FALSE,
# 					   lsc.converse = FALSE,
# 					   ira.converse = FALSE,
# 					   irb.converse = FALSE,
# 					   genome.length = TRUE,
# 					   total.gc = TRUE,
# 					   show.indel = indel_highlight,
# 					   gene.no = TRUE,
# 					   rrn.no = TRUE,
# 					   trn.no = TRUE,
# 					   organelle_type = TRUE,
# 					   background = backgroundColor,
# 					   gc.color = "#888888",
# 					   gc.background = GCbackground,
# 					   info.background = infoBackground,
# 					   ir.color = "#2F3941",
# 					   ssc.color = "#82B6E2",
# 					   lsc.color = "#299E96",
# 					   shadow.color = "#0000FF20",
# 					   psa.color = "#2A6332",
# 					   psb.color = "#4C8805",
# 					   pet.color = "#7F992C",
# 					   atp.color = "#9FBB3D",
# 					   ndh.color = "#FEEE50",
# 					   rbc.color = "#4D9E3F",
# 					   rpo.color = "#AE2D29",
# 					   rsp.color = "#D6AD7C",
# 					   rpl.color = "#9C7A4B",
# 					   clp_mat_inf.color = "#D9662D",
# 					   ycf.color = "#71B8A9",
# 					   trn.color = "#172C7F",
# 					   rrn.color = "#D1382A",
# 					   other_gene.color = "#7D7D7D",
# 					   show.genes = show_genes,
# 					   # gene_axis_ir.color = ir.color,
# 					   # gene_axis_ssc.color = ssc.color,
# 					   # gene_axis_lsc.color = lsc.color,
# 					   cu.bias = TRUE,
# 					   customize.ring1 = NULL,
# 					   customize.ring1.type = "line + dot",
# 					   # "line", "line + filling", "line + dot", "line + dot + filling", "step line", "step line + filling", "vertical line"
# 					   # customize.ring1.color = gc.color,
# 					   customize.ring2 = NULL,
# 					   customize.ring2.type = "line + dot",
# 					   # customize.ring2.color = gc.color,
# 					   customize.ring3 = NULL,
# 					   # customize.ring3.color = gc.color
# 					   )
# # <- 4. Plot

# -> 5. Save parameters
pdf_name <- "results.pdf"
jpeg_name <- "results.jpeg"
width <- 10.00
height <- 8.00
units <- "in"
font <- fonts
# <- 5. Save parameters

# -> 6. PDF
pdf(file = pdf_name,
	width = width,
	height = height,
	family = font
)
PlotPlastidGenome(plot.tables = plot_table,
				  save = FALSE,
				  # # file.type = "pdf",
				  # text.size = 1,
				  height = c(0.1, 0.2, 0.07),
				  # file.name = NULL,
				  shadow = shadow,
				  ir.gc = ir_gc, # GCofIR
				  gc.per.gene = gc_gene,
				  pseudo = pseudo_mark,
				  legend = TRUE,
				  ssc.converse = FALSE,
				  lsc.converse = FALSE,
				  ira.converse = FALSE,
				  irb.converse = FALSE,
				  genome.length = TRUE,
				  total.gc = TRUE,
				  show.indel = indel_highlight,
				  gene.no = TRUE,
				  rrn.no = TRUE,
				  trn.no = TRUE,
				  organelle_type = TRUE,
				  background = backgroundColor,
				  gc.color = "#888888",
				  gc.background = GCbackground,
				  info.background = infoBackground,
				  ir.color = "#2F3941",
				  ssc.color = "#82B6E2",
				  lsc.color = "#299E96",
				  shadow.color = "#0000FF20",
				  psa.color = "#2A6332",
				  psb.color = "#4C8805",
				  pet.color = "#7F992C",
				  atp.color = "#9FBB3D",
				  ndh.color = "#FEEE50",
				  rbc.color = "#4D9E3F",
				  rpo.color = "#AE2D29",
				  rsp.color = "#D6AD7C",
				  rpl.color = "#9C7A4B",
				  clp_mat_inf.color = "#D9662D",
				  ycf.color = "#71B8A9",
				  trn.color = "#172C7F",
				  rrn.color = "#D1382A",
				  other_gene.color = "#7D7D7D",
				  show.genes = show_genes,
				  # gene_axis_ir.color = ir.color,
				  # gene_axis_ssc.color = ssc.color,
				  # gene_axis_lsc.color = lsc.color,
				  cu.bias = TRUE,
				  customize.ring1 = NULL,
				  customize.ring1.type = "line + dot",
				  # "line", "line + filling", "line + dot", "line + dot + filling", "step line", "step line + filling", "vertical line"
				  # customize.ring1.color = gc.color,
				  customize.ring2 = NULL,
				  customize.ring2.type = "line + dot",
				  # customize.ring2.color = gc.color,
				  customize.ring3 = NULL,
				  # customize.ring3.color = gc.color
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
PlotPlastidGenome(plot.tables = plot_table,
				  save = FALSE,
				  # # file.type = "pdf",
				  # text.size = 1,
				  height = c(0.1, 0.2, 0.07),
				  # file.name = NULL,
				  shadow = shadow,
				  ir.gc = ir_gc, # GCofIR
				  gc.per.gene = gc_gene,
				  pseudo = pseudo_mark,
				  legend = TRUE,
				  ssc.converse = FALSE,
				  lsc.converse = FALSE,
				  ira.converse = FALSE,
				  irb.converse = FALSE,
				  genome.length = TRUE,
				  total.gc = TRUE,
				  show.indel = indel_highlight,
				  gene.no = TRUE,
				  rrn.no = TRUE,
				  trn.no = TRUE,
				  organelle_type = TRUE,
				  background = backgroundColor,
				  gc.color = "#888888",
				  gc.background = GCbackground,
				  info.background = infoBackground,
				  ir.color = "#2F3941",
				  ssc.color = "#82B6E2",
				  lsc.color = "#299E96",
				  shadow.color = "#0000FF20",
				  psa.color = "#2A6332",
				  psb.color = "#4C8805",
				  pet.color = "#7F992C",
				  atp.color = "#9FBB3D",
				  ndh.color = "#FEEE50",
				  rbc.color = "#4D9E3F",
				  rpo.color = "#AE2D29",
				  rsp.color = "#D6AD7C",
				  rpl.color = "#9C7A4B",
				  clp_mat_inf.color = "#D9662D",
				  ycf.color = "#71B8A9",
				  trn.color = "#172C7F",
				  rrn.color = "#D1382A",
				  other_gene.color = "#7D7D7D",
				  show.genes = show_genes,
				  # gene_axis_ir.color = ir.color,
				  # gene_axis_ssc.color = ssc.color,
				  # gene_axis_lsc.color = lsc.color,
				  cu.bias = TRUE,
				  customize.ring1 = NULL,
				  customize.ring1.type = "line + dot",
				  # "line", "line + filling", "line + dot", "line + dot + filling", "step line", "step line + filling", "vertical line"
				  # customize.ring1.color = gc.color,
				  customize.ring2 = NULL,
				  customize.ring2.type = "line + dot",
				  # customize.ring2.color = gc.color,
				  customize.ring3 = NULL,
				  # customize.ring3.color = gc.color
)
dev.off()
# <- 7. JPEG