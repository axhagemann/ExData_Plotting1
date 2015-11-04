setwd("~/coursera/ex_data_analysis/exdata_data_household_power_consumption")

# modify the data with linux cmd tools head, grep and cat

# read data
data <- read.table(file="household_power_consumption_cut.txt", sep=";", header = TRUE, dec=".", stringsAsFactors=FALSE)


