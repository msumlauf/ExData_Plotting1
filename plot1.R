## Data Science Specialization
## Exploratory Data Analysis
## Week 1 Course Project
##
## plot1

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
png("plot1.png", width=480, height=480)
hist(hpc$Global_active_power,
     col="red",
     xlab="Global Active Power (kilowatts)",
     main="Global Active Power")
dev.off()
