# Author: Benben Miao
# Email: benben.miao@outlook.com
# Rversion: 4.2.0
# Date: 2022-04-28

# -> 0. Install and Library
# install.packages(c("ggplot2", "ggsci"))
# BiocManager::install(c("EnhancedVolcano"))
library(ggsci)
library(ggplot2)
library(factoextra)
# <- 0. Install and Library

# -> 1. File read
file_path = "data/USArrests.txt"

file_format = "txt"
# "xlsx", "xls", "txt", "csv" 
if (file_format == "xlsx" | file_format == "xls") { 
  data <- readxl::read_excel(path = file_path, 
                             sheet = NULL, 
                             col_names = TRUE, 
                             na = "", 
                             progress = readxl::readxl_progress()) 
} else if (file_format == "txt") { 
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
row.names(data) <- data[,1]
data <- data[,-1]
data <- na.omit(data)
# <- 2. Data

# -> 3. Plot parameters
fonts <- "Times"
# ChoiceBox: "Times", "Palatino", "Bookman", "Courier", "Helvetica", "URWGothic", "NimbusMon", "NimbusSan"

ggTheme <- "theme_bw"
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

sciColorAlpha <- 0.92
sciColor <- "Default"
# ChoiceBox: "Sci_AAAS", "Sci_NPG", "Sci_Simpsons", "Sci_JAMA", "Sci_GSEA", "Sci_Lancet", "Sci_Futurama", "Sci_JCO", "Sci_NEJM", "Sci_IGV", "Sci_UCSC", "Sci_D3", "Sci_Material"
if (sciColor == "Default"){
  sci_color <- NULL
} else if (sciColor == "Sci_AAAS") {
  sci_color <- scale_color_aaas(alpha = sciColorAlpha)
  # Science and Science Translational Medicine:
} else if (sciColor == "Sci_NPG") {
  sci_color <- scale_color_npg(alpha = sciColorAlpha)
} else if (sciColor == "Sci_Simpsons") {
  sci_color <- scale_color_simpsons(alpha = sciColorAlpha)
  # The Simpsons
} else if (sciColor == "Sci_JAMA") {
  sci_color <- scale_color_jama(alpha = sciColorAlpha)
  # The Journal of the American Medical Association
} else if (sciColor == "Sci_Lancet") {
  sci_color <- scale_color_lancet(alpha = sciColorAlpha)
  #  Lancet Oncology
} else if (sciColor == "Sci_Futurama") {
  sci_color <- scale_color_futurama(alpha = sciColorAlpha)
  # Futurama
} else if (sciColor == "Sci_JCO") {
  sci_color <- scale_color_jco(alpha = sciColorAlpha)
  # Journal of Clinical Oncology: 
} else if (sciColor == "Sci_NEJM") {
  sci_color <- scale_color_nejm(alpha = sciColorAlpha)
  # The New England Journal of Medicine
} else if (sciColor == "Sci_IGV") {
  sci_color <- scale_color_igv(alpha = sciColorAlpha)
  # Integrative Genomics Viewer (IGV)
} else if (sciColor == "Sci_UCSC") {
  sci_color <- scale_color_ucscgb(alpha = sciColorAlpha)
  # UCSC Genome Browser chromosome sci_color
} else if (sciColor == "Sci_D3") {
  sci_color <- scale_color_d3(alpha = sciColorAlpha)
  # D3.JS
} else if (sciColor == "Sci_Material") {
  sci_color <- scale_color_material(alpha = sciColorAlpha)
  # The Material Design color palettes
}

legendPos <- "right"
# ChoiceBox: "none", "left", "right", "bottom", "top"

legendDir <- "vertical"
# ChoiceBox: "vertical", "horizontal"

clusterFunction <- "kmeans"
# ChoiceBox: "kmeans", "hclust", "agnes", "clara", "diana", "fanny", "pam"

kMax <- 10
# Slider: 10, 1, 1, 50

dataStand <- "origin"
if (dataStand == "origin") {
  stand <- FALSE
} else if (dataStand == "standard") {
  stand <- TRUE
}
# ChoiseBox: "origin", "standard"

hclusterMetric <- "euclidean"
# ChoiceBox: "euclidean", "manhattan", "maximum", "canberra", "binary", "minkowski", "pearson", "spearman", "kendall"

hclusterMethod <- "ward.D2"
# ChoiceBox: "ward.D", "ward.D2", "single", "complete", "average", "mcquitty", "median", "centroid"

nBoot <- 100
# Slider: 100, 10, 10, 1000
# <- 3. Plot parameters

# # -> 4. Plot
ecluster <- eclust(data,
                   FUNcluster = clusterFunction,
                   k = NULL,
                   k.max = kMax,
                   stand = stand,
                   graph = TRUE,
                   hc_metric = hclusterMetric,
                   hc_method = hclusterMethod,
                   nboot = nBoot,
                   seed = 123)
p <- fviz_cluster(ecluster) + 
  theme(
    text = element_text(family = fonts),
    legend.position = legendPos,
    legend.direction = legendDir
  ) + 
  guides(text = "none") +
  sci_color +
  gg_theme
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