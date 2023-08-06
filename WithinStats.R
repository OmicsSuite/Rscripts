# Author: Benben Miao
# Email: benben.miao@outlook.com
# Rversion: 4.2.0
# Date: 2022-11-30

# -> 0. Install and Library
# install.packages(c("ggplot2", "ggsci"))
# install.packages("ggstatsplot")
# install.packages("rstantools")
# install.packages("PMCMRplus")
# install.packages("afex")
library(ggplot2)
library(ggsci)
library(ggstatsplot)
library(rstantools)
library(PMCMRplus)
library(afex)
# <- 0. Install and Library

options (warn = -1)

# -> 1. File Read
file_path = "data/WithinStats/WithinStats.txt"
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
# set.seed(123)
# wdata = data.frame(
#     sex = factor(rep(c("F", "M"), each=200)),
#     weight = c(rnorm(200, 55), rnorm(200, 58)))
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

sciFillAlpha <- 0.30
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

title <- "Violin and Box Plot with Statistics"
# TextField

xlab <- colnames(data)[2]
ylab <- colnames(data)[1]
# ==========

groupLevel <- "Three_Column"
# ChoiceBox: "Two_Column", "Three_Column"

# plotType <- "boxviolin"
# ChoiceBox: "boxviolin", "box", "violin"

statMethod <- "parametric"
# ChoiceBox: "parametric", "nonparametric", "robust", "bayes"

pairTest <- "PairTest_Yes"
# ChoiceBox: "PairTest_Yes", "PairTest_No"
if (pairTest == "PairTest_Yes") {
    pairwise_comparisons <- TRUE 
} else if (pairTest == "PairTest_No") {
    pairwise_comparisons <- FALSE
}

pairTestValue <- "all"
# ChoiceBox: "significant", "non-significant", "all"

pAdjustMethod <- "holm"
# ChoiceBox: "holm", "hochberg", "hommel", "bonferroni", "BH", "BY", "fdr", "none"

effectSizeType <- "unbiased"
# ChoiceBox: "unbiased", "biased", "eta", "omega"

displayBayesFactor <- "BayesFactor_Show"
# ChoiceBox: "BayesFactor_Show", "BayesFactor_Hidden"
if (displayBayesFactor == "BayesFactor_Show") {
    bf_message <- TRUE
} else if (displayBayesFactor == "BayesFactor_Hidden") {
    bf_message <- FALSE
}

confidenceIntervals <- 0.95
# Slider: 0.95, 0.00, 1.00, 0.01

pointSize <- 5
# Slider: 3, 0, 10, 1

pointAlpha <- 0.80
# Slider: 0.50, 0.00, 1.00, 0.01

pathShow <- "Path_Show"
# ChoiceBox: "Path_Show", "Path_Hidden"
if (pathShow == "Path_Show") {
    point_path <- TRUE
} else if (pathShow == "Path_Hidden") {
    point_path <- FALSE
}

lineType <- "solid" 
# ChoiceBox: "blank", "solid", "dashed", "dotted", "dotdash", "longdash", "twodash"

lineWidth <- 0.5
# Slider: 0.5, 0.0, 10.0, 0.1

lineAlpha <- 0.20
# Slider: 0.50, 0.00, 1.00, 0.01

violinAlpha <- 0.30
# Slider: 0.30, 0.00, 1.00, 0.01

plotColumn <- 2
# Slider: 2, 1, 10, 1

colorPalette <- "default_aaas"
# ChoiceBox: "default_aaas", "nrc_npg", "default_nejm", "lanonc_lancet", "default_jama", "default_jco", "default_ucscgb", "default_igv", "default_locuszoom", "default_uchicago", "default_gsea"

# ==========
plotTitleFace <- "bold"
# ChoiceBox: "plain", "italic", "bold", "bold.italic"

plotTitleSize <- 18
# Slider: 18, 0, 50, 1

plotTitleHjust <- 0.5
# Slider: 0.5, 0.0, 1.0, 0.1

axisTitleFace <- "plain"
# ChoiceBox: "plain", "italic", "bold", "bold.italic"

axisTitleSize <- 16
# Slider: 16, 0, 50, 1

axisTextSize <- 10
# Slider: 10, 0, 50, 1

legendTitleSize <- 12
# Slider: 12, 0, 50, 1

legendPosition <- "right"
# ChoiceBox: "none", "left", "right", "bottom", "top"

legendDirection <- "vertical"
# ChoiceBox: "horizontal", "vertical"

groups <- unique(data[[2]])
my_comparisons <- combn(groups, 2, simplify = FALSE)
my_comparisons <- lapply(my_comparisons, as.character)

symnum_args <- list(cutpoints = c(0, 0.0001, 0.001, 0.01, 0.05, 1), 
                    symbols = c("****", "***", "**", "*", "ns"))
# <- 3. Plot Parameters

# # -> 4. Plot
if (groupLevel == "Two_Column") {
    colnames(data) <- c("Value", "Level1")
    set.seed(123)
    p <- ggwithinstats(data = data,
                        x = Level1,
                        y = Value,
                        # plot.type = plotType, # "boxviolin", "box", "violin"
                        type = statMethod,
                        pairwise.comparisons = pairwise_comparisons,
                        pairwise.display = pairTestValue,
                        p.adjust.method = pAdjustMethod,
                        effsize.type = effectSizeType,
                        bf.prior = 0.707,
                        bf.message = bf_message,
                        results.subtitle = TRUE,
                        # title = title,
                        xlab = xlab,
                        ylab = ylab,
                        caption = NULL,
                        subtitle = NULL,
                        k = 2L,
                        var.equal = FALSE,
                        conf.level = confidenceIntervals,
                        nboot = 100L,
                        tr = 0.2,
                        centrality.plotting = TRUE,
                        centrality.type = statMethod,
                        centrality.point.args = list(size = 5, 
                                                     color = "#333333"),
                        centrality.label.args = list(size = 3, 
                                                     nudge_x = 0.4, 
                                                     segment.linetype = 4,
                                                     min.segment.length = 0),
                        centrality.path = TRUE,
                        centrality.path.args = list(linewidth = 1, 
                                                    color = "red", 
                                                    alpha = 0.5),
                        point.args = list(alpha = pointAlpha, 
                                          size = pointSize, stroke = 0),
                        point.path = point_path,
                        point.path.args = list(alpha = lineAlpha, 
                                               linetype = lineType, 
                                               linewidth = lineWidth, 
                                               color = "#008000"),
                        outlier.tagging = FALSE,
                        outlier.label = NULL,
                        outlier.coef = 1.5,
                        # outlier.shape = shape,
                        # outlier.color = "#ff0000",
                        outlier.label.args = list(size = 3),
                        boxplot.args = list(width = 0.2, 
                                            alpha = 0.5),
                        violin.args = list(width = 0.5,
                                           alpha = violinAlpha
                                           # aes(color = data[[2]]
                                           #     fill = data[[2]]
                                           # )
                        ),
                        ggsignif.args = list(textsize = 3,
                                             tip_length = 0.01),
                        ggtheme = ggstatsplot::theme_ggstatsplot(),
                        package = "ggsci",
                        palette = colorPalette
                        # ggplot.component = NULL,
        ) + 
        # labs(color = colnames(data)[2],
        #      fill = colnames(data)[2]
        #      ) +
        # sci_fill +
        # sci_color +
        # gg_theme +
        theme(text = element_text(family = fonts)
              # plot.title = element_text(face = plotTitleFace,
              #                           # "plain", "italic", "bold", "bold.italic"
              #                           size = plotTitleSize,
              #                           hjust = plotTitleHjust
              # ),
              # axis.title = element_text(face = axisTitleFace,
              #                           # "plain", "italic", "bold", "bold.italic"
              #                           size = axisTitleSize
              # ),
              # axis.text = element_text(face = "plain",
              #                          size = axisTextSize
              # ),
              # legend.title = element_text(face = "plain",
              #                             size = legendTitleSize
              # ),
              # legend.position = legendPosition,
              # # "none", "left", "right", "bottom", "top"
              # legend.direction = legendDirection
              # # "horizontal" or "vertical"
        )
} else if (groupLevel == "Three_Column") {
    colnames(data) <- c("Value", "Level1", "Level2")
    set.seed(123)
    p <- grouped_ggwithinstats(data = data,
                       x = Level1,
                       y = Value,
                       grouping.var = Level2,
                       # plot.type = plotType, # "boxviolin", "box", "violin"
                       type = statMethod,
                       pairwise.comparisons = pairwise_comparisons,
                       pairwise.display = pairTestValue,
                       p.adjust.method = pAdjustMethod,
                       effsize.type = effectSizeType,
                       bf.prior = 0.707,
                       bf.message = bf_message,
                       results.subtitle = TRUE,
                       # title = title,
                       xlab = xlab,
                       ylab = ylab,
                       caption = NULL,
                       subtitle = NULL,
                       k = 2L,
                       var.equal = FALSE,
                       conf.level = confidenceIntervals,
                       nboot = 100L,
                       tr = 0.2,
                       centrality.plotting = TRUE,
                       centrality.type = statMethod,
                       centrality.point.args = list(size = 5, 
                                                    color = "#333333"),
                       centrality.label.args = list(size = 3, 
                                                    nudge_x = 0.4, 
                                                    segment.linetype = 4,
                                                    min.segment.length = 0),
                       centrality.path = TRUE,
                       centrality.path.args = list(linewidth = 1, 
                                                   color = "red", 
                                                   alpha = 0.5),
                       point.args = list(alpha = pointAlpha, 
                                         size = pointSize, stroke = 0),
                       point.path = point_path,
                       point.path.args = list(alpha = lineAlpha, 
                                              linetype = lineType, 
                                              linewidth = lineWidth, 
                                              color = "#008000"),
                       outlier.tagging = FALSE,
                       outlier.label = NULL,
                       outlier.coef = 1.5,
                       # outlier.shape = shape,
                       # outlier.color = "#ff0000",
                       outlier.label.args = list(size = 3),
                       boxplot.args = list(width = 0.2, 
                                           alpha = 0.5),
                       violin.args = list(width = 0.5,
                                          alpha = violinAlpha
                                          # aes(color = data[[2]]
                                          #     fill = data[[2]]
                                          # )
                       ),
                       ggsignif.args = list(textsize = 3,
                                            tip_length = 0.01),
                       ggtheme = ggstatsplot::theme_ggstatsplot(),
                       package = "ggsci",
                       palette = colorPalette,
                       # ggplot.component = NULL,
                       plotgrid.args = list(ncol = plotColumn)
        ) + 
        # labs(color = colnames(data)[2],
        #      fill = colnames(data)[2]
        #      ) +
        # sci_fill +
        # sci_color +
        # gg_theme +
        theme(text = element_text(family = fonts)
              # plot.title = element_text(face = plotTitleFace,
              #                           # "plain", "italic", "bold", "bold.italic"
              #                           size = plotTitleSize,
              #                           hjust = plotTitleHjust
              # ),
              # axis.title = element_text(face = axisTitleFace,
              #                           # "plain", "italic", "bold", "bold.italic"
              #                           size = axisTitleSize
              # ),
              # axis.text = element_text(face = "plain",
              #                          size = axisTextSize
              # ),
              # legend.title = element_text(face = "plain",
              #                             size = legendTitleSize
              # ),
              # legend.position = legendPosition,
              # # "none", "left", "right", "bottom", "top"
              # legend.direction = legendDirection
              # # "horizontal" or "vertical"
        )
}
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