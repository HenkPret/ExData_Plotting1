#=================================================================================================#
# Load packages used in script
require(dplyr)
require(lubridate)
require(reshape2)

# Set working directory
setwd("C:/Users/Henk/Desktop/May 2016/April 2016/Coursera R/Working_directory/Exploratory data analysis")

# Read data and onvert to tbl_df for dplyr usage
hhpowerdata <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)
hhpowerdata <- tbl_df(hhpowerdata)

# Convert first variable from factor to date 
hhpowerdata$Date <- as.Date(hhpowerdata$Date, format = "%d/%m/%Y")

# Subset dataframe based on required dates only and save as new dataset
hhpowerdatasubset <- filter(hhpowerdata, Date =="2007-02-01" | Date== "2007-02-02")

#=================================================================================================#
# PLOT 1: Red histogram with Global Active Power Frequency

# Change Global Active Power to numeric variable to enable plotting
hhpowerdatasubset$Global_active_power <- as.numeric(as.character(hhpowerdatasubset$Global_active_power))

# Plot histogram and specify plot details
hist(hhpowerdatasubset$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

# Copy plot to PNG file
dev.copy(png, file = "plot1.png")
dev.off()

