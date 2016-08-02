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
# PLOT 3: Energy sub metering over two days

# Combine date and time and convert this variable to date and time format
hhpowerdatasubset$newdatetime <- paste(hhpowerdatasubset$Date, hhpowerdatasubset$Time)
hhpowerdatasubset$newdatetime <- ymd_hms(hhpowerdatasubset$newdatetime)

# Subset data to contain only datetime and values of sub metering data (3 variables)
hhpowersub2 <- hhpowerdatasubset[,grep(("^Sub|newdatetime"), colnames(hhpowerdatasubset))]

# Melt subset data from wide to long for easier plotting
melteddata <- melt(hhpowersub2, id = "newdatetime")

# Plot melted data
with(melteddata, plot(newdatetime,value, type = "n", pch=NA_integer_,
                      xlab ="",ylab = "Energy sub metering")) 

with(subset(melteddata, variable == "Sub_metering_1"), lines(newdatetime, value,
                                                             col = "black"))

with(subset(melteddata, variable == "Sub_metering_2"), lines(newdatetime, value,
                                                             col = "red"))

with(subset(melteddata, variable == "Sub_metering_3"), lines(newdatetime, value,
                                                             col = "blue"))

legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 1,  y.intersp = 0.45)

# Copy plot to PNG file
dev.copy(png, file = "plot3.png")
dev.off()
