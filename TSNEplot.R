# Author: Benben Miao
# Email: benben.miao@outlook.com
# Rversion: 4.2.0
# Date: 2022-04-28

# -> 0. Install and Library
# install.packages("ggcorrplot")
# install.packages("readxl")
library(Rtsne)
library(vegan)
library(ggplot2)
library(ggsci)
# <- 0. Install and Library

# -> 1. File read
file_path = "data/TSNEPlot/Flower-Data.txt"
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

# -> 2. NA and Duplicated
tsne_tb <- as.data.frame(data)
rownames(tsne_tb) <- tsne_tb[,1]
tsne_data <- tsne_tb[,2:(ncol(tsne_tb)-1)]
groups <- tsne_tb[,ncol(tsne_tb)]

tsne_ano <- anosim(x = tsne_data,
                   grouping = groups)
tsne_p <- tsne_ano$signif
tsne_r <- round(tsne_ano$statistic,3)

set.seed(as.numeric(123))
tsne_res <- Rtsne(as.matrix(unique(tsne_data)),
                  dims = 2,
                  initial_dims = 50,
                  perplexity = 10,
                  theta = 0.0,
                  check_duplicates = TRUE,
                  pca = T,
                  partial_pca = FALSE,
                  max_iter = 1000,
                  verbose = getOption("verbose", FALSE),
                  is_distance = FALSE,
                  # Y_init = NULL,
                  pca_center = TRUE,
                  pca_scale = FALSE,
                  normalize = TRUE,
                  # stop_lying_iter = ifelse(is.null(Y_init), 250L,0L),
                  # mom_switch_iter = ifelse(is.null(Y_init), 250L, 0L),
                  momentum = 0.5,
                  final_momentum = 0.8,
                  eta = 200,
                  exaggeration_factor = 12,
                  num_threads = 2
)
# head(tsne_res)
tsne_out <- as.data.frame(tsne_res$Y)
write.table(tsne_out,
            file = "Results.txt",
            append = FALSE,
            sep = "\t",
            quote = FALSE,
            na = "NA"
)
colnames(tsne_out) <- c("tSNE1","tSNE2")

# percentage <- round(tsne_res$sdev / sum(tsne_res$sdev) * 100, 2)
# percentage <- paste( colnames(tsne_out), "(", paste( as.character(percentage), "%", ")", sep="") )
# <- 2. NA and Duplicated

# -> 3. Plot parameters
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

tsne_geom_point_size <- 3
# slide: 5, 0, 0.1, 20
tsne_geom_point_alpha <- 0.8
# slide: 0.8, 0, 0.1, 1

tsne_geom_text_size <- 2
# slide: 6, 0, 0.1, 20
tsne_geom_text_alpha <- 0.8
# slide: 0.8, 0, 0.1, 1

tsne_ellipse_alpha <- 0.3
# slide: 0.3, 0, 0.1, 1
tsne_ellipse_level <- 0.95
# slide: 0.95, 0, 0.01, 1

sciColorAlpha <- 0.92
sciColor <- "Sci_NPG"
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
# <- 3. Plot parameters

# # -> 4. Plot
p <- ggplot(tsne_out,
            aes(x=tSNE1,y=tSNE2,
                color = groups,
                shape = NULL,
                label=row.names(tsne_data))) +
  geom_point(size = tsne_geom_point_size,
             alpha = tsne_geom_point_alpha) +
  geom_text(size = tsne_geom_text_size,
            alpha = tsne_geom_text_alpha,
            show.legend = FALSE) +
  # xlab(percentage[1]) +
  # ylab(percentage[2]) +
  stat_ellipse(aes(x = tSNE1, y = tSNE2,
                   fill = groups),
               geom = "polygon",
               alpha = tsne_ellipse_alpha,
               level = tsne_ellipse_level,
               show.legend = FALSE
  ) +
  annotate("text",
           x = min(tsne_out$tSNE1) + ((max(tsne_out$tSNE1) - min(tsne_out$tSNE1)) * 0.2),
           y = max(tsne_out$tSNE2),
           parse = TRUE,
           size = 5,
           label = paste('R:',tsne_r),
           colour = "black") +
  annotate("text",
           x = min(tsne_out$tSNE1) + ((max(tsne_out$tSNE1) - min(tsne_out$tSNE1)) * 0.2),
           y = max(tsne_out$tSNE2) - ((max(tsne_out$tSNE2) - min(tsne_out$tSNE2)) * 0.1),
           parse = TRUE,
           size = 5,
           label = paste('P:',tsne_p),
           colour = "black") +
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