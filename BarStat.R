# Author: Benben Miao
# Email: benben.miao@outlook.com
# Rversion: 4.2.0
# Date: 2022-11-30

Sys.setlocale("LC_ALL", "en_US.UTF-8")
options(warn = -1)

# -> 0. Install and Library
# install.packages(c("ggplot2", "ggsci"))
# install.packages("ggpubr")
library(ggplot2)
library(ggsci)
library(ggpubr)
# library(babynames)
# library(dplyr)
# <- 0. Install and Library

# -> 1. File Read
file_path = "data/BarStat/Bar-Stat.txt"
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

sciFillAlpha <- 0.50
sciColorAlpha <- 0.80
sciFillColor <- "Sci_AAAS"
# ChoiceBox: "Sci_AAAS", "Sci_NPG", "Sci_Simpsons", "Sci_JAMA", "Sci_GSEA", "Sci_Lancet", "Sci_Futurama", "Sci_JCO", "Sci_NEJM", "Sci_IGV", "Sci_UCSC", "Sci_D3", "Sci_Material"
if (sciFillColor == "Default") {
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

myShape <- "plus_times"
# ChoiceBox: "border_square", "border_circle", "border_triangle", "plus", "times", "border_diamond", "border_triangle_down", "square_times", "plus_times", "diamond_plus", "circle_plus", "di_triangle", "square_plus", "circle_times","square_triangle", "fill_square", "fill_circle", "fill_triangle", "fill_diamond", "large_circle", "small_circle", "fill_border_circle", "fill_border_square", "fill_border_diamond", "fill_border_triangle"
if (myShape == "border_square") {
    shape <- 0
} else if (myShape == "border_circle") {
    shape <- 1
} else if (myShape == "border_triangle") {
    shape <- 2
} else if (myShape == "plus") {
    shape <- 3
} else if (myShape == "times") {
    shape <- 4
} else if (myShape == "border_diamond") {
    shape <- 5
} else if (myShape == "border_triangle_down") {
    shape <- 6
} else if (myShape == "square_times") {
    shape <- 7
} else if (myShape == "plus_times") {
    shape <- 8
} else if (myShape == "diamond_plus") {
    shape <- 9
} else if (myShape == "circle_plus") {
    shape <- 10
} else if (myShape == "di_triangle") {
    shape <- 11
} else if (myShape == "square_plus") {
    shape <- 12
} else if (myShape == "circle_times") {
    shape <- 13
} else if (myShape == "square_triangle") {
    shape <- 14
} else if (myShape == "fill_square") {
    shape <- 15
} else if (myShape == "fill_circle") {
    shape <- 16
} else if (myShape == "fill_triangle") {
    shape <- 17
} else if (myShape == "fill_diamond") {
    shape <- 18
} else if (myShape == "large_circle") {
    shape <- 19
} else if (myShape == "small_circle") {
    shape <- 20
} else if (myShape == "fill_border_circle") {
    shape <- 21
} else if (myShape == "fill_border_square") {
    shape <- 22
} else if (myShape == "fill_border_diamond") {
    shape <- 23
} else if (myShape == "fill_border_triangle") {
    shape <- 24
}

title <- "Bar with Stat"
# TextField

xlab <- colnames(data)[2]
ylab <- colnames(data)[1]

groupLevel <- "Two_Level"
# ChoiceBox: "Two_Level", "Three_Level"

borderSize <- 1.0
# ChoiceBox: 1.0, 0.0, 10.0, 0.1

barWidth <- 0.8
# Slider: 0.8, 0.0, 1.0, 0.1

barPosition <- "Dodge"
# ChoiceBox: "Dodge", "Nudge", "Stack", "Fill", "Jitter"
if (barPosition == "Dodge") {
    position <- position_dodge()
} else if (barPosition == "Stack") {
    position <- position_stack()
} else if (barPosition == "Fill") {
    position <- position_fill()
} else if (barPosition == "Nudge") {
    position <- position_nudge()
} else if (barPosition == "Jitter") {
    position <- position_jitter()
}

barOrientation <- "vertical"
# ChoiceBox: "vertical", "horizontal", "reverse"

groupSort <- "none"
# ChoiceBox: "none", "asc", "desc"

labelShow <- "Label_Show"
# ChoiceBox: "Label_Show", "Label_Hidden"
if (labelShow == "Label_Show") {
    label_show <- TRUE
} else if (labelShow == "Label_Hidden") {
    label_show <- FALSE
}

labelColor <- "#ffffff"
# ColorPicker

labelSize <- 5.0
# Slider: 5.0, 0.0, 30.0, 0.1

labelPosition <- "in"
# ChoiceBox: "in", "out"

labelVjust <- 1.0
# Slider: 1.0, -10.0, 10.0, 0.1

labelHjust <- 0.5
# Slider: 0.5, -10.0, 10.0, 0.1

addElement <- "mean_se"
# ChoiceBox: "none", "dotplot", "jitter", "boxplot", "point", "mean", "mean_se", "mean_sd", "mean_ci", "mean_range", "median", "median_iqr", "median_hilow", "median_q1q3", "median_mad", "median_range"

errorPlot <- "errorbar"
# ChoiceBox: "pointrange", "linerange", "crossbar", "errorbar", "upper_errorbar", "lower_errorbar", "upper_pointrange", "lower_pointrange", "upper_linerange", "lower_linerange"

lineType <- "solid"
# ChoiceBox: "blank", "solid", "dashed", "dotted", "dotdash", "longdash", "twodash"

elementSize <- 1.0
# Slider: 1.0, 0.0, 10.0, 0.1

elementAlpha <- 1.00
# Slider: 0.50, 0.00, 1.00, 0.01

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
# <- 3. Plot Parameters

# # -> 4. Plot
if (groupLevel == "Two_Level") {
    p <- ggbarplot(data,
                  x = colnames(data)[2],
                  y = colnames(data)[1],
                  combine = FALSE,
                  merge = FALSE,
                  color = colnames(data)[2],
                  fill = colnames(data)[2],
                  size = borderSize,
                  width = barWidth,
                  # alpha = violinAlpha,
                  title = title,
                  xlab = xlab,
                  ylab = ylab,
                  # facet.by = colnames(data)[3],
                  # panel.labs = NULL,
                  # short.panel.labs = FALSE,
                  select = NULL,
                  remove = NULL,
                  order = NULL,
                  position = position, # position_dodge(0.9), NULL
                  orientation = barOrientation, # "vertical", "horizontal", "reverse"
                  sort.val = groupSort, # "none", "asc", "desc"
                  sort.by.groups = TRUE,
                  label = label_show,
                  lab.col = labelColor,
                  lab.size = labelSize,
                  lab.pos = labelPosition, # "in", "out"
                  lab.vjust = labelVjust,
                  lab.hjust = labelHjust,
                  add = addElement,
                  add.params = list(color = colnames(data)[2],
                                    fill = colnames(data)[2],
                                    shape = shape,
                                    size = elementSize,
                                    alpha = elementAlpha,
                                    linetype = lineType
                                    ),
                  # "none", "dotplot", "jitter", "boxplot", "point", "mean", "mean_se", "mean_sd", "mean_ci", "mean_range", "median", "median_iqr", "median_hilow", "median_q1q3", "median_mad", "median_range"
                  error.plot = errorPlot
                  # "pointrange", "linerange", "crossbar", "errorbar", "upper_errorbar", "lower_errorbar", "upper_pointrange", "lower_pointrange", "upper_linerange", "lower_linerange"
        ) +
        sci_fill +
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
} else if (groupLevel == "Three_Level") {
    p <- ggbarplot(data,
                   x = colnames(data)[2],
                   y = colnames(data)[1],
                   combine = FALSE,
                   merge = FALSE,
                   color = colnames(data)[3],
                   fill = colnames(data)[3],
                   size = borderSize,
                   width = barWidth,
                   # alpha = violinAlpha,
                   title = title,
                   xlab = xlab,
                   ylab = ylab,
                   # facet.by = colnames(data)[3],
                   # panel.labs = NULL,
                   # short.panel.labs = FALSE,
                   select = NULL,
                   remove = NULL,
                   order = NULL,
                   position = position, # position_dodge(0.9), NULL
                   orientation = barOrientation, # "vertical", "horizontal", "reverse"
                   sort.val = groupSort, # "none", "asc", "desc"
                   sort.by.groups = TRUE,
                   label = label_show,
                   lab.col = labelColor,
                   lab.size = labelSize,
                   lab.pos = labelPosition, # "in", "out"
                   lab.vjust = labelVjust,
                   lab.hjust = labelHjust
                   # add = addElement,
                   # add.params = list(color = colnames(data)[3],
                   #                   fill = colnames(data)[3],
                   #                   shape = shape,
                   #                   size = elementSize,
                   #                   alpha = elementAlpha,
                   #                   linetype = lineType
                   # ),
                   # # "none", "dotplot", "jitter", "boxplot", "point", "mean", "mean_se", "mean_sd", "mean_ci", "mean_range", "median", "median_iqr", "median_hilow", "median_q1q3", "median_mad", "median_range"
                   # error.plot = errorPlot
                   # "pointrange", "linerange", "crossbar", "errorbar", "upper_errorbar", "lower_errorbar", "upper_pointrange", "lower_pointrange", "upper_linerange", "lower_linerange"
        ) +
        sci_fill +
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