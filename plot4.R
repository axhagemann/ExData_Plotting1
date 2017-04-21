#setwd("~/Coursera/ex_data_analysis")

# Coursera Exploratory Data Analysis Course Assignment 1
# Read data, subset it and reconstruct plots to match

# plot 4

# modify the data with linux cmd tools head, grep and cat to keep the header and filter for the 2 specified dates
# modified data is in GitHub repo

# set locale for R to display weekdays in english
Sys.setlocale("LC_TIME", "C");

# read data with character classes
data <- read.table(file="household_power_consumption_cut.txt", sep=";", header = TRUE, dec=".", stringsAsFactors=FALSE)

# parse date and time columns
data$datetime <- strptime(paste(data$Date, data$Time), "%e/%m/%Y %H:%M:%S")

# convert char to numeric values and save it as a new column
data$Global_active_powerNum <- as.numeric(data$Global_active_power)
data$Sub_metering_1Num <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2Num <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3Num <- as.numeric(data$Sub_metering_3)
data$VoltageNum <- as.numeric(data$Voltage)
data$Global_reactive_powerNum <- as.numeric(data$Global_reactive_power)

# the initial subsetting did not work.
# subset the date
working <- data[data$Date %in% c("1/2/2007", "2/2/2007"), ]

# plot the output as a 480x480 png file
png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = 72, type="cairo")

# use par to get a 2x2 for output
par(mfrow=c(2,2))

# first plot graph from plot2
plot(working$datetime,working$Global_active_powerNum, type="l", xlab="", ylab="Global Active Power (kilowatts)")
# plot top left
plot(working$datetime,working$VoltageNum, type="l", col="black", xlab="datetime", ylab="Voltage")

#plot bottomn left
plot(working$datetime, working$Sub_metering_1Num, type="l", ylab="Energy sub metering", col="black", xlab="")
lines(working$datetime, working$Sub_metering_2Num, col="red")
lines(working$datetime, working$Sub_metering_3Num, col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_2"), lty=1, col=c("black","red","blue"), bty="n")

# plot bottomn right
plot(working$datetime, working$Global_reactive_powerNum, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
