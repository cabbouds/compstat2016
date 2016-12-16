library(ggplot2)
library(plotly)
setwd("./")
data_wine <-read.csv("./wine.csv")
Rcpp::sourceCpp("./T5/cpp_funs_matrix.cpp")

# Tarea 5
source("./T5/5_ui.R")
source("./T5/5_server.R")

# Tarea 4
source("./T4/4_ui.R")
source("./T4/4_server.R")


# Tarea 2
source("./T2/2_ui.R")
source("./T2/2_server.R")


# Tarea 1
source("./T1/1_ui.R")
source("./T1/1_server.R")


