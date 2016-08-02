#=================================================================================================#
# Load packages used in script
require(dplyr)
require(lubridate)
require(reshape2)

# Set working directory
setwd("./Working_directory/Exploratory data analysis")

# Read data and onvert to tbl_df for dplyr usage
hhpowerdata <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)
hhpowerdata <- tbl_df(hhpowerdata)

# Convert first variable from factor to date 
hhpowerdata$Date <- as.Date(hhpowerdata$Date, format = "%d/%m/%Y")

# Subset dataframe based on required dates only and save as new dataset
hhpowerdatasubset <- filter(hhpowerdata, Date =="2007-02-01" | Date== "2007-02-02")

#=================================================================================================#
# PLOT 2: Line graph of Global Active Power (GAP) time series over two days

# Combine date and time and convert this variable to date and time format
hhpowerdatasubset$newdatetime <- paste(hhpowerdatasubset$Date, hhpowerdatasubset$Time)
hhpowerdatasubset$newdatetime <- ymd_hms(hhpowerdatasubset$newdatetime)

# Convert Global Active Power to numeric variable to enable plotting
hhpowerdatasubset$Global_active_power <- as.numeric(as.character(hhpowerdatasubset$Global_active_power))

# Plot the GAP by date and time
plot(hhpowerdatasubset$newdatetime, hhpowerdatasubset$Global_active_power, pch=NA_integer_, 
     xlab ="",ylab = "Global Active Power (kilowatts)")

# Add lines to the graph
lines(hhpowerdatasubset$newdatetime, hhpowerdatasubset$Global_active_power)

# Copy plot to PNG file
dev.copy(png, file = "plot2.png")
dev.off()
