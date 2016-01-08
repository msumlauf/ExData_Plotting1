## Data Science Specialization
## Exploratory Data Analysis
## Week 1 Course Project
##
## plot4

# Package dependencies
library(dplyr)
library(lubridate)

# Retrieve file and load data
if (!file.exists("household_power_consumption.txt")) {
  download.file(
    "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
    destfile="household_power_consumption.zip"
  )
  unzip("household_power_consumption.zip")
}
hpc <- read.table("household_power_consumption.txt",
  header=TRUE,
  sep=";",
  na.strings="?",
  stringsAsFactors=FALSE)

# Prepare data
hpc$DT = dmy_hms(paste(hpc$Date, hpc$Time))
hpc <- hpc %>% 
       filter(year(DT)==2007 & month(DT)==2 & day(DT) %in% c(1,2)) %>%
       select(-Date, -Time)

# Build plot
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

# 1st chart
plot(hpc$Global_active_power ~ hpc$DT,
     type="l",
     xlab="",
     ylab="Global Active Power")

# 2nd chart
plot(hpc$Voltage ~ hpc$DT,
     type="l",
     xlab="",
     ylab="Voltage",
     sub="datetime")

# 3rd chart
plot(
  hpc$DT,
  hpc$Sub_metering_1,
  type="n",
  xlab="",
  ylab="Energy sub metering"
)
lines(hpc$DT, hpc$Sub_metering_1, col="black")
lines(hpc$DT, hpc$Sub_metering_2, col="red")
lines(hpc$DT, hpc$Sub_metering_3, col="blue")
legend("topright", bty="n", lwd=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# 4th chart
plot(hpc$Global_reactive_power ~ hpc$DT,
     type="l",
     xlab="",
     ylab="Global_reactive_power",
     sub="datetime")

dev.off()
