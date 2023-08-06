# Author: Benben Miao
# Email: benben.miao@outlook.com
# Rversion: 4.2.0
# Date: 2022-06-09

# -> 0. Install and Library
library(survival)
library(survminer)
# <- 0. Install and Library

# -> 1. File read
file_path = "data/Survival.txt"
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
colnames(data) <- c("Time", "Status", "Group")

fit <- survfit(Surv(Time, Status == 1) ~ Group, data = data)

xLimEnd <- max(data$Time)
data <- data[data[,1] < xLimEnd,]
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

sciPalette <- "npg"
# ChoiceBox: "npg", "aaas", "lancet", "jco", "ucscgb", "uchicago", "simpsons", "rickandmorty"

curveFunction <- "pct"
# ChoiceBox: "pct", "event", "cumhaz"

confInterval <- "ShowConfInterval"
if (confInterval == "ShowConfInterval") {
  conf_int <- TRUE
} else if (confInterval == "HindConfInterval") {
  conf_int <- FALSE
}
# ChoiceBox: "ShowConfInterval", "HindConfInterval"

confIntervalStyle <- "ribbon"
# ChoiceBox: "ribbon", "step"

riskTable <- "ShowRiskTable"
if (riskTable == "ShowRiskTable") {
  risk_table <- TRUE
} else if (riskTable == "HindRiskTable") {
  risk_table <- FALSE
}
# ChoiceBox: "ShowRiskTable", "HindRiskTable"

numCensor <- "ShowNumCensor"
if (numCensor == "ShowNumCensor") {
  num_censor <- TRUE
} else if (numCensor == "HindNumCensor") {
  num_censor <- FALSE
}
# ChoiceBox: "ShowNumCensor", "HindNumCensor"

xLimStart <- 0
# Slider: 0 0,1,1000

yLimStart <- 0
# Slider: 0 0,1,100

yLimEnd <- 100
# Slider: 100 0,1,100

breakX <- 100
# Slider: 100 1,1,1000

breakY <- 25
# Slider: 25 1,5,100

# <- 3. Plot parameters

# # -> 4. Plot
p <- ggsurvplot(
  fit,
  data = data,
  fun = curveFunction,
  risk.table = risk_table,
  pval = TRUE,
  conf.int = conf_int,
  conf.int.style = confIntervalStyle,
  size = 1,
  xlab = "Time",
  ylab = "Survival probability",
  ggtheme = gg_theme,
  risk.table.y.text.col = TRUE,
  risk.table.height = 0.25,
  risk.table.y.text = TRUE,
  ncensor.plot = num_censor,
  ncensor.plot.height = 0.25,
  surv.median.line = "hv",
  palette = sciPalette,
  xlim = c(xLimStart, xLimEnd),
  ylim = c(yLimStart, yLimEnd),
  break.x.by = breakX,
  break.y.by = breakY
)
# p
# # <- 4. Plot

# -> 5. Save parameters
pdf_name <- "results.pdf"
jpeg_name <- "results.jpeg"
width <- 9
height <- 7
units <- "in"
fonts <- "Times"
# <- 5. Save parameters

# -> 6. PDF
pdf(file = pdf_name,
    width = width,
    height = height,
    family = fonts,
    onefile = FALSE
    )

print(p)

dev.off()
# <- 6. PDF

# -> 7. JPEG
jpeg(filename = jpeg_name,
     width = 9,
     height = 7,
     units = units,
     res = 300,
     quality = 100,
     family = fonts
     )

print(p)

dev.off()
# <- 7. JPEG

# # -> 5. Save parameters
# pdf_name = "results.pdf"
# jpeg_name = "results.jpeg" 
# device_pdf = "pdf" 
# device_jpeg = "jpeg" 
# # "pdf", "jpeg", "tiff", "png", "bmp", "svg" 
# width = 9 
# height = 7 
# units = "in" 
# # "in", "cm", "mm", "px" 
# dpi <- 300 
# # <- 5. Save parameters
# 
# # -> 6. Save image
# library(patchwork)
# 
# pp <- p$plot / p$table / p$ncensor.plot
# # pp
# 
# ggsave( 
#   filename = pdf_name, 
#   plot = pp, 
#   device = device_pdf, 
#   path = NULL, 
#   scale = 1, 
#   width = width, 
#   height = height, 
#   units = units, 
#   dpi = 300, 
#   limitsize = TRUE
# )
# ggsave( 
#   filename = jpeg_name, 
#   plot = p$plot, 
#   device = device_jpeg, 
#   path = NULL, 
#   scale = 1, 
#   width = width, 
#   height = height, 
#   units = units, 
#   dpi = 300, 
#   limitsize = TRUE 
# )
# # <- 6. Save image