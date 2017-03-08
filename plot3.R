# plot3.R
# Creates histogram plot of Global Active Power

# Use lubridate for date function
library(lubridate)

# Look for the file and download it, if needed

filename <- "household_power_consumption.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("household_power_consumption.txt")) { 
  unzip(filename) 
}

# In order to limit the data being loaded, we're going to load just the particular
# rows from the file.  Looking at the file ahead of time the data is in date/time
# order. There is a header line containing the column titles and
# the lines holding the data for 2/1/2007 - 2/2/2007 are 66638-69517


# Grab the first row of the file to get the column headers
pow_headers <- read.table(file="household_power_consumption.txt",sep=";", header = FALSE, nrows=1)
pow_headers <- as.character(t(pow_headers[1,]))

# Load just the rows we want to work with
pow_dat <- read.table(file="household_power_consumption.txt",sep=";",header = FALSE, skip=66637, nrows = 2880)

# Put column headers in place
names(pow_dat) <- pow_headers

# Create a datetime column from the Date and Time data
pow_dat$Date_Time <- dmy_hms(paste(as.character(t(pow_dat[,1])),as.character(t(pow_dat[,2]))))

# Create the plot
plot(pow_dat$Date_Time, pow_dat$Sub_metering_1, col="black", type="l", pch="NA", ylab="Energy sub metering", xlab="")
lines(pow_dat$Date_Time, pow_dat$Sub_metering_2, col="red", type="l", pch="NA")
lines(pow_dat$Date_Time, pow_dat$Sub_metering_3, col="blue", type="l", pch="NA")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=c(2,2,2),col=c("black","red","blue"))

dev.copy(png,"plot3.png")
dev.off()