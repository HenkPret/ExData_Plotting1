#=================================================================================================#
# PLOT 4:  Multiple plots

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

# Create 2 rows and 2 columns for plots
par(mfrow = c(2, 2))

# PLOT TOP LEFT

# Combine date and time and convert this variable to date and time format
hhpowerdatasubset$newdatetime <- paste(hhpowerdatasubset$Date, hhpowerdatasubset$Time)
hhpowerdatasubset$newdatetime <- ymd_hms(hhpowerdatasubset$newdatetime)

# Convert Global Active Power to numeric variable to enable plotting
hhpowerdatasubset$Global_active_power <- as.numeric(as.character(hhpowerdatasubset$Global_active_power))

# Plot the GAP by date and time
plot(hhpowerdatasubset$newdatetime, hhpowerdatasubset$Global_active_power, pch=NA_integer_, 
     xlab ="",ylab = "Global Active Power")

# Add lines to the graph
lines(hhpowerdatasubset$newdatetime, hhpowerdatasubset$Global_active_power)

# PLOT TOP RIGHT

# Convert Voltage to numeric variable to enable plotting
hhpowerdatasubset$Voltage <- as.numeric(as.character(hhpowerdatasubset$Voltage))

# Plot the Voltage by date and time
plot(hhpowerdatasubset$newdatetime, hhpowerdatasubset$Voltage, pch=NA_integer_, 
     xlab ="datetime",ylab = "Voltage")

# Add lines to the graph
lines(hhpowerdatasubset$newdatetime, hhpowerdatasubset$Voltage)

# PLOT BOTTOM RIGHT

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

legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
       lty=c(1,1), bty="n", cex=.5,  y.intersp = 0.25)

# PLOT BOTTOM LEFT
# Convert Global reactive power to numeric variable to enable plotting
hhpowerdatasubset$Global_reactive_power <- as.numeric(as.character(hhpowerdatasubset$Global_reactive_power))

# Plot the Global reactive power by date and time
plot(hhpowerdatasubset$newdatetime, hhpowerdatasubset$Global_reactive_power, pch=NA_integer_, 
     xlab ="datetime",ylab = "Global_reactive_power")

# Add lines to the graph
lines(hhpowerdatasubset$newdatetime, hhpowerdatasubset$Global_reactive_power)

# Copy plot to PNG file
dev.copy(png, file = "plot4.png")
dev.off()

