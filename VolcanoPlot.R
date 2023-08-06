# Author: Benben Miao
# Email: benben.miao@outlook.com
# Rversion: 4.2.0
# Date: 2022-04-28

# -> 0. Install and Library
# install.packages(c("ggplot2", "ggsci"))
# BiocManager::install(c("EnhancedVolcano"))
library(ggplot2)
library(ggsci)
library(EnhancedVolcano)
# <- 0. Install and Library

# -> 1. File read
file_path = "data/Differentially-Expressed-Genes.txt"
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

# -> 2. Data
data <- as.data.frame(data)
rownames(data) <- data[,1]
data <- data[,-1]
colnames(data) <- c("log2FoldChange", "pvalue", "padj")
# <- 2. Data

# -> 3. Plot parameters
fonts <- "Times"
# ChoiceBox: "Times", "Palatino", "Bookman", "Courier", "Helvetica", "URWGothic", "NimbusMon", "NimbusSan"

sciColor <- "Default"
# ChoiceBox: "Sci_AAAS", "Sci_NPG", "Sci_Simpsons", "Sci_JAMA", "Sci_GSEA", "Sci_Lancet", "Sci_Futurama", "Sci_JCO", "Sci_NEJM", "Sci_IGV", "Sci_UCSC", "Sci_D3", "Sci_Material"
if (sciColor == "Default"){
  sci_color <- NULL
} else if (sciColor == "Sci_AAAS") {
  sci_color <- scale_color_aaas()
  # Science and Science Translational Medicine:
} else if (sciColor == "Sci_NPG") {
  sci_color <- scale_color_npg()
} else if (sciColor == "Sci_Simpsons") {
  sci_color <- scale_color_simpsons()
  # The Simpsons
} else if (sciColor == "Sci_JAMA") {
  sci_color <- scale_color_jama()
  # The Journal of the American Medical Association
} else if (sciColor == "Sci_Lancet") {
  sci_color <- scale_color_lancet()
  #  Lancet Oncology
} else if (sciColor == "Sci_Futurama") {
  sci_color <- scale_color_futurama()
  # Futurama
} else if (sciColor == "Sci_JCO") {
  sci_color <- scale_color_jco()
  # Journal of Clinical Oncology: 
} else if (sciColor == "Sci_NEJM") {
  sci_color <- scale_color_nejm()
  # The New England Journal of Medicine
} else if (sciColor == "Sci_IGV") {
  sci_color <- scale_color_igv()
  # Integrative Genomics Viewer (IGV)
} else if (sciColor == "Sci_UCSC") {
  sci_color <- scale_color_ucscgb()
  # UCSC Genome Browser chromosome sci_color
} else if (sciColor == "Sci_D3") {
  sci_color <- scale_color_d3()
  # D3.JS
} else if (sciColor == "Sci_Material") {
  sci_color <- scale_color_material()
  # The Material Design color palettes
}


# sciColor <- "Default"
# # ChoiceBox: "Sci_AAAS", "Sci_NPG", "Sci_Simpsons", "Sci_JAMA", "Sci_GSEA", "Sci_Lancet", "Sci_Futurama", "Sci_JCO", "Sci_NEJM", "Sci_IGV", "Sci_UCSC", "Sci_D3", "Sci_Material"
# if (sciColor == "Default"){
#   sci_color <- NULL
# } else if (sciColor == "Sci_AAAS") {
#   sci_color <- scale_fill_aaas()
#   # Science and Science Translational Medicine:
# } else if (sciColor == "Sci_NPG") {
#   sci_color <- scale_fill_npg()
# } else if (sciColor == "Sci_Simpsons") {
#   sci_color <- scale_fill_simpsons()
#   # The Simpsons
# } else if (sciColor == "Sci_JAMA") {
#   sci_color <- scale_fill_jama()
#   # The Journal of the American Medical Association
# } else if (sciColor == "Sci_Lancet") {
#   sci_color <- scale_fill_lancet()
#   #  Lancet Oncology
# } else if (sciColor == "Sci_Futurama") {
#   sci_color <- scale_fill_futurama()
#   # Futurama
# } else if (sciColor == "Sci_JCO") {
#   sci_color <- scale_fill_jco()
#   # Journal of Clinical Oncology: 
# } else if (sciColor == "Sci_NEJM") {
#   sci_color <- scale_fill_nejm()
#   # The New England Journal of Medicine
# } else if (sciColor == "Sci_IGV") {
#   sci_color <- scale_fill_igv()
#   # Integrative Genomics Viewer (IGV)
# } else if (sciColor == "Sci_UCSC") {
#   sci_color <- scale_fill_ucscgb()
#   # UCSC Genome Browser chromosome sci_color
# } else if (sciColor == "Sci_D3") {
#   sci_color <- scale_fill_d3()
#   # D3.JS
# } else if (sciColor == "Sci_Material") {
#   sci_color <- scale_fill_material()
#   # The Material Design color palettes
# }

# opacity <- 0.8
# # Slider: 0.5, 0, 0.1, 1.0
# 
# sciColor <- "Sci_UCSC"
# # ChoiceBox: "Sci_AAAS", "Sci_NPG", "Sci_Simpsons", "Sci_JAMA", "Sci_GSEA", "Sci_Lancet", "Sci_Futurama", "Sci_JCO", "Sci_NEJM", "Sci_IGV", "Sci_UCSC", "Sci_D3", "Sci_Material"
# if (sciColor == "Sci_AAAS"){
#   sci_color <- pal_aaas(palette = c("default"), alpha = opacity)(10)
#   # Science and Science Translational Medicine:
#   # "#3B4992FF" "#EE0000FF" "#008B45FF" "#631879FF" "#008280FF" "#BB0021FF" "#5F559BFF" "#A20056FF" "#808180FF" "#1B1919FF"
# } else if (sciColor == "Sci_NPG") {
#   sci_color <- pal_npg(palette = "nrc", alpha = opacity)(10)
# } else if (sciColor == "Sci_Simpsons") {
#   sci_color <- pal_simpsons(palette = "springfield", alpha = opacity)(16)
#   # The Simpsons
# } else if (sciColor == "Sci_JAMA") {
#   sci_color <- pal_jama(palette = c("default"), alpha = opacity)(8)
#   # The Journal of the American Medical Association
#   # "#374E55FF" "#DF8F44FF" "#00A1D5FF" "#B24745FF" "#79AF97FF" "#6A6599FF" "#80796BFF"
# } else if (sciColor == "Sci_GSEA") {
#   sci_color <- pal_gsea(palette = c("default"), alpha = opacity, reverse = FALSE)(12)
#   # GSEA GenePattern
#   # "#4500ACFF" "#2600D1FF" "#6B58EEFF" "#8787FFFF" "#C6C0FFFF" "#D4D4FFFF" "#FFBFE5FF" "#FF8888FF" "#FF707FFF" "#FF5959FF" "#EE3F3FFF" "#D60C00FF"
# } else if (sciColor == "Sci_Lancet") {
#   sci_color <- pal_lancet(palette = c("lanonc"), alpha = opacity)(9)
#   #  Lancet Oncology
#   # "#00468BFF" "#ED0000FF" "#42B540FF" "#0099B4FF" "#925E9FFF" "#FDAF91FF" "#AD002AFF" "#ADB6B6FF" "#1B1919FF"
# } else if (sciColor == "Sci_Futurama") {
#   sci_color <- pal_futurama(palette = c("planetexpress"), alpha = opacity)(12)
#   # Futurama
#   # "#FF6F00FF" "#C71000FF" "#008EA0FF" "#8A4198FF" "#5A9599FF" "#FF6348FF" "#84D7E1FF" "#FF95A8FF" "#3D3B25FF" "#ADE2D0FF" "#1A5354FF" "#3F4041FF"
# } else if (sciColor == "Sci_JCO") {
#   sci_color <- pal_jco(palette = c("default"), alpha = opacity)(10)
#   # Journal of Clinical Oncology: 
#   # "#0073C2FF" "#EFC000FF" "#868686FF" "#CD534CFF" "#7AA6DCFF" "#003C67FF" "#8F7700FF" "#3B3B3BFF" "#A73030FF" "#4A6990FF"
# } else if (sciColor == "Sci_NEJM") {
#   sci_color <- pal_nejm(palette = c("default"), alpha = opacity)(8)
#   # The New England Journal of Medicine
# } else if (sciColor == "Sci_IGV") {
#   sci_color <- pal_igv(palette = c("default", "alternating"), alpha = opacity)(51)
#   # Integrative Genomics Viewer (IGV)
# } else if (sciColor == "Sci_UCSC") {
#   sci_color <- pal_ucscgb(palette = "default", alpha = opacity)(26)
#   # UCSC Genome Browser chromosome sci_color
# } else if (sciColor == "Sci_D3") {
#   sci_color <- pal_d3(palette = "category20",alpha = opacity)(20)
#   # D3.JS
# } else if (sciColor == "Sci_Material") {
#   sci_color <- pal_material(palette = "orange", n = 100, alpha = opacity, reverse = FALSE)(100)
#   # The Material Design color palettes
# }

colorNS <- "#88888888"
# ColorPicker

colorLog2FC <- "#00800088"
# ColorPicker

colorPvalue <- "#0088ee88"
# ColorPicker

colorLog2FCandP <- "#ff000088"
# ColorPicker

pqValue <- "pvalue"
# ChoiceBox: "pvalue", "padj"

pCutoff <- 0.005
# Slider: 0.005, 0.000, 0.001, 1.000

log2FcCutoff <- 1.0
# Slider: 1.0, 0.0, 0.1, 10.0

cutoffLineType <- "longdash"
# ChoiceBox: "blank", "solid", "dashed", "dotted", "dotdash", "longdash", "twodash"

pointSize <- 1.0
# Slider: 1.0, 0.0, 0.1, 5.0

labelSize <- 3.0
# Slider: 3.0, 0.0, 0.1, 10.0

boxedLabel <- "OnlyLable"
if (boxedLabel == "BoxLable") {
  boxedLabels <- TRUE
} else if (boxedLabel == "OnlyLable") {
  boxedLabels <- FALSE
}
# ChoiceBox: "OnlyLable", "BoxLable"

drawConnector <- "OnlyLable"
if (drawConnector == "OnlyLable") {
  drawConnectors <- FALSE
} else if (drawConnector == "LineLable") {
  drawConnectors <- TRUE
}
# ChoiceBox: "OnlyLable", "LineLable"

pointShape <- 19
# Slider: 19, 0, 1, 25

pointAlpha <- 0.5
# Slider: 0.5, 0.0, 0.1, 1.0

legendPosition <- "right"
# ChoiceBox: "right", "left", "top", "bottom"

majorGrid <- "Show"
if (majorGrid == "Show") {
  majorGrids <- TRUE
} else if (majorGrid == "Hidden") {
  majorGrids <- FALSE
}
# ChoiceBox: "Show", "Hidden"

minorGrid <- "Show"
if (minorGrid == "Show") {
  minorGrids <- TRUE
} else if (minorGrid == "Hidden") {
  minorGrids <- FALSE
}
# ChoiceBox: "Show", "Hidden"
# <- 3. Plot parameters

# # -> 4. Plot
p <- EnhancedVolcano(
  data,
  lab = rownames(data),
  x = "log2FoldChange",
  y = pqValue,
  xlim = c(min(data[,"log2FoldChange"], na.rm=TRUE),
           max(data[,"log2FoldChange"], na.rm=TRUE)),
  ylim = c(0, max(-log10(data[,pqValue]), na.rm=TRUE) + 5),
  xlab = paste("Log2","fold change"),
  ylab = paste("-Log10",pqValue),
  axisLabSize = 16,
  title = NULL,
  subtitle = NULL,
  caption = paste0('Total = ', nrow(data), ' variables'),
  # titleLabSize = 20,
  # subtitleLabSize = 18,
  captionLabSize = 16,
  pCutoff = pCutoff,
  FCcutoff = log2FcCutoff,
  cutoffLineType = cutoffLineType,
  cutoffLineCol = 'black',
  cutoffLineWidth = 0.4,
  pointSize = pointSize,
  labSize = labelSize,
  labCol = 'black',
  labFace = 'plain',
  boxedLabels = boxedLabels,
  drawConnectors = drawConnectors,
  shape = pointShape,
  col = c(colorNS, colorLog2FC, colorPvalue, colorLog2FCandP),
  colAlpha = pointAlpha,
  legendLabels = c("NS","Log2 FC","P","P & Log2 FC"),
  legendPosition = legendPosition,
  legendLabSize = 14,
  legendIconSize = 5.0,
  legendDropLevels = TRUE,
  widthConnectors = 0.5,
  typeConnectors = 'closed',
  endsConnectors = 'first',
  lengthConnectors = unit(0.01, 'npc'),
  colConnectors = 'grey10',
  gridlines.major = majorGrids,
  gridlines.minor = minorGrids,
  border = "partial",
  borderWidth = 0.8,
  borderColour = "black") +
  theme(text = element_text(family = fonts))
# # <- 4. Plot

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