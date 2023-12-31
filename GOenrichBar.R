# Author: Benben Miao
# Email: benben.miao@outlook.com
# Rversion: 4.2.0
# Date: 2022-04-28

# -> 0. Install and Library
library(clusterProfiler)
library(enrichplot)
library(ggplot2)
library(ggsci)
library(reshape2)
library(tidyr)
library(dplyr)
# <- 0. Install and Library

# -> 1. File read
gene_go <- read.table("data/Gene-GO.txt",
                      header = TRUE,
                      sep = "\t",
                      quote = "",
                      stringsAsFactors = F)

deg_fc <- read.table("data/DEG-List.txt",
                     header = TRUE,
                     sep = "\t",
                     quote = "",
                     stringsAsFactors = F)
# <- 1. File read

# -> 2. Data Parameters
pAdjustMethod <- "fdr"
# ChoiceBox: "holm", "hochberg", "hommel", "bonferroni", "BH", "BY", "fdr", "none"

pCutoff <- 0.30
# Slider: 0.30, 0.00, 0.01, 1.00

qCutoff <- 0.50
# Slider: 0.50, 0.00, 0.01, 1.00
# <- 2. Data Parameters

# -> 3. Data
deg_fc["log2FC"] <- 2^(deg_fc["log2FC"])
deg_list <- with(deg_fc, setNames(log2FC, id))

gene_go1 <- melt(gene_go,
                 na.rm = FALSE,
                 id.vars = c("id"),
                 measure.vars = c("biological_process", "cellular_component", "molecular_function"),
                 variable.name = "ontology",
                 value.name = "term",
                 factorsAsStrings = TRUE
)

gene_go2 <- separate_rows(data = gene_go1,
                          "term",
                          sep = ";"
)

gene_go3 <- separate(gene_go2,
                     "term",
                     c("term", "description"),
                     "\\("
)

gene_go4 <- drop_na(gene_go3)
gene_go4["description"] <- gsub(")", "", gene_go4$description)
gene_go4["ontology"] <- gsub("_", " ", gene_go4$ontology)

gene_go5 <- data.frame(gene_go4["id"],
                       gene_go4["term"],
                       gene_go4["ontology"],
                       gene_go4["description"]
)

enrich_results <- enricher(gene = deg_fc[[1]][-1],
                           TERM2GENE = data.frame(gene_go5[,2],gene_go5[,1]), 
                           TERM2NAME = data.frame(gene_go5[,2],gene_go5[,4]),
                           pvalueCutoff = pCutoff,
                           pAdjustMethod = pAdjustMethod, # "holm", "hochberg", "hommel", "bonferroni", "BH", "BY", "fdr", "none"
                           qvalueCutoff = qCutoff,
                           minGSSize = 1,
                           maxGSSize = 1000
)

enrich_result <- enrich_results@result

gene_go6 <- data.frame(gene_go5["term"], gene_go5["ontology"])
gene_go6 <- distinct(gene_go6, .keep_all = TRUE)

enrich_table <- merge(gene_go6, 
                      enrich_result,
                      by.x = "term",
                      by.y = "ID"
)
colnames(enrich_table)[1] <- "ID"

write.table(enrich_table, 
            file = "Results.txt", 
            append = FALSE,
            sep = "\t",
            quote = TRUE,
            na = "NA"
)
# <- 3. Data

# -> 4. Plot parameters
fonts <- "Times"
# ChoiceBox: "Times", "Palatino", "Bookman", "Courier", "Helvetica", "URWGothic", "NimbusMon", "NimbusSan"

sciFillAlpha <- 0.92
sciFill <- "Sci_D3"
# ChoiceBox: "Sci_AAAS", "Sci_NPG", "Sci_Simpsons", "Sci_JAMA", "Sci_GSEA", "Sci_Lancet", "Sci_Futurama", "Sci_JCO", "Sci_NEJM", "Sci_IGV", "Sci_UCSC", "Sci_D3", "Sci_Material"
if (sciFill == "Default"){
  sci_fill <- NULL
} else if (sciFill == "Sci_AAAS") {
  sci_fill <- scale_fill_aaas(alpha = sciFillAlpha)
  # Science and Science Translational Medicine:
} else if (sciFill == "Sci_NPG") {
  sci_fill <- scale_fill_npg(alpha = sciFillAlpha)
} else if (sciFill == "Sci_Simpsons") {
  sci_fill <- scale_fill_simpsons(alpha = sciFillAlpha)
  # The Simpsons
} else if (sciFill == "Sci_JAMA") {
  sci_fill <- scale_fill_jama(alpha = sciFillAlpha)
  # The Journal of the American Medical Association
} else if (sciFill == "Sci_Lancet") {
  sci_fill <- scale_fill_lancet(alpha = sciFillAlpha)
  #  Lancet Oncology
} else if (sciFill == "Sci_Futurama") {
  sci_fill <- scale_fill_futurama(alpha = sciFillAlpha)
  # Futurama
} else if (sciFill == "Sci_JCO") {
  sci_fill <- scale_fill_jco(alpha = sciFillAlpha)
  # Journal of Clinical Oncology: 
} else if (sciFill == "Sci_NEJM") {
  sci_fill <- scale_fill_nejm(alpha = sciFillAlpha)
  # The New England Journal of Medicine
} else if (sciFill == "Sci_IGV") {
  sci_fill <- scale_fill_igv(alpha = sciFillAlpha)
  # Integrative Genomics Viewer (IGV)
} else if (sciFill == "Sci_UCSC") {
  sci_fill <- scale_fill_ucscgb(alpha = sciFillAlpha)
  # UCSC Genome Browser chromosome sci_fill
} else if (sciFill == "Sci_D3") {
  sci_fill <- scale_fill_d3(alpha = sciFillAlpha)
  # D3.JS
} else if (sciFill == "Sci_Material") {
  sci_fill <- scale_fill_material(alpha = sciFillAlpha)
  # The Material Design color palettes
}

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

signBy <- "p.adjust"
# ChoiceBox: "pvalue", "p.adjust", "qvalue"

categoryNum <- 30
# ChoiceBox: 30, 10, 1, 50

lowColor <- "#ff0000aa"
# ColorPicker

highColor <- "#0000ffaa"
# ColorPicker

fontSize <- 12
# Slider: 12, 2, 2, 30
# <- 4. Plot parameters

# -> 5. Plot
p <- barplot(
  height = enrich_results,
  x = "GeneRatio", # 'Count' and 'GeneRatio'
  color = signBy,
  showCategory = categoryNum,
  font.size = fontSize,
  title = "",
  label_format = 200
  ) +
  geom_text(aes(label = Count),
            vjust = 0.3, 
            hjust = -0.5,
            size = 3,
            color = "#333333") +
  geom_text(aes(label = paste("(",round(GeneRatio, 2),")", sep = "")),
            vjust = 0.3, 
            hjust = -0.5,
            size = 3,
            color = "#333333") +
  xlab("Gene Number") +
  ylab("GO terms") +
  gg_theme +
  theme(
    text = element_text(family = fonts),
    axis.text = element_text(colour = "#000000")
  ) +
  scale_fill_gradient(low = lowColor, high = highColor, space = "Lab")

# p
# <- 5. Plot

# -> 6. Save parameters
pdf_name <- "results.pdf" # plotPDFPath
jpeg_name <- "results.jpeg" # plotJPEGPath
device_pdf <- "pdf" 
device_jpeg <- "jpeg" 
# "pdf", "jpeg", "tiff", "png", "bmp", "svg" 
width <- 9 
height <- 7 
units <- "in" 
# "in", "cm", "mm", "px" 
dpi <- 300 
# <- 6. Save parameters

# -> 7. Save image
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
# <- 7. Save image