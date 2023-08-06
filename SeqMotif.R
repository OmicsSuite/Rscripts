# Author: Benben Miao
# Email: benben.miao@outlook.com
# Rversion: 4.2.0
# Date: 2022-11-30

# -> 0. Install and Library
# install.packages(c("ggplot2", "ggsci"))
# BiocManager::install(c("EnhancedVolcano"))
library(ggplot2)
library(ggsci)
library(ggseqlogo)
# <- 0. Install and Library

# -> 1. File Read
file_path = "data/SeqMotif/Seq-Motif.txt"
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
data <- data[, !sapply(data, function(x) {
    all(is.na(x))
})]
data <- as.list(data)
data <- lapply(data, function(x) {
    return(x[!is.na(x)])
})
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

seqType <- "auto"
# ChoiceBox: "auto", "dna","rna", "aa", "other"

numCol <- 3
# Slider: 3, 0, 10, 1

method <- "bits"
# ChoiceBox: "bits","prob"

colScheme <- "auto"
# ChoiceBox: "auto","chemistry", "chemistry2", "hydrophobicity", "nucleotide", "nucleotide2", "base_pairing", "clustalx", "taylor"

font <- "roboto_slab_bold"
# ChoiceBox: "helvetica_regular", "helvetica_bold", "helvetica_light", "roboto_slab_light", "roboto_regular", "roboto_slab_regular", "roboto_medium", "roboto_bold", "roboto_slab_bold", "akrobat_regular", "akrobat_bold", "xkcd_regular"

titleSize <- 12
# Slider: 12, 0, 50, 1

titleFace <- "bold"
# ChoiceBox: "plain", "bold", "italic", "bold.italic"
# <- 3. Plot Parameters

# # -> 4. Plot
p <- ggseqlogo(data,
               seq_type = seqType,
               ncol = numCol,
               method = method,
               col_scheme = colScheme,
               font = font
               ) + 
    gg_theme +
    theme(
        text = element_text(family = fonts),
        title = element_text(
            size = titleSize,
            face = titleFace
            ),
        strip.text = element_text(
            size = titleSize,
            face = titleFace
            )
        )
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