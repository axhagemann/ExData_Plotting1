#setwd("~/Coursera/ex_data_analysis")

# Coursera Exploratory Data Analysis Course Assignment 1
# Read data, subset it and reconstruct plots to match


# modify the data with linux cmd tools head, grep and cat to keep the header and filter for the 2 specified dates
# modified data is in GitHub repo

# plot 1


# read data with character classes
data <- read.table(file="household_power_consumption_cut.txt", sep=";", header = TRUE, dec=".", stringsAsFactors=FALSE)

# parse date and time columns
data$datetime <- strptime(paste(data$Date, data$Time), "%e/%m/%Y %H:%M:%S")

# convert global active power to numeric values and save it as a new column
data$Global_active_powerNum <- as.numeric(data$Global_active_power)

# the initial subsetting did not work.
# subset the date
working <- data[data$Date %in% c("1/2/2007", "2/2/2007"), ]

# plot the output as a 480x480 png file
png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA)
hist(working$Global_active_powerNum, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()
