#setwd("~/Coursera/ex_data_analysis")

# Coursera Exploratory Data Analysis Course Assignment 1
# Read data, subset it and reconstruct plots to match

# plot 3

# modify the data with linux cmd tools head, grep and cat to keep the header and filter for the 2 specified dates
# modified data is in GitHub repo


# set locale for R to display weekdays in english
Sys.setlocale("LC_TIME", "C");

# read data with character classes
data <- read.table(file="household_power_consumption_cut.txt", sep=";", header = TRUE, dec=".", stringsAsFactors=FALSE)

# parse date and time columns
data$datetime <- strptime(paste(data$Date, data$Time), "%e/%m/%Y %H:%M:%S")

# convert character to numeric values and save it as a new column
data$Global_active_powerNum <- as.numeric(data$Global_active_power)
data$Sub_metering_1Num <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2Num <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3Num <- as.numeric(data$Sub_metering_3)

# the initial subsetting did not work.
# subset the date
working <- data[data$Date %in% c("1/2/2007", "2/2/2007"), ]


# plot the output as a 480x480 png file
png(filename = "plot3.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA, type="cairo")
plot(working$datetime, working$Sub_metering_1Num, type="l", ylab="Energy sub metering", col="black", xlab="")

# add 2nd series
lines(working$datetime, working$Sub_metering_2Num, col="red")

# add 3rd series
lines(working$datetime, working$Sub_metering_3Num, col="blue")

# add legend
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_2"), lty=1, col=c("black","red","blue"))

dev.off()
