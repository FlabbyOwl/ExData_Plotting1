# Loading full data set. Missing values = "?" - change it on NA
# Separation = ";"
data <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# Load dplyr package for subsetting rows. 
library(dplyr)

# Create variable of subset data by dates what we need. 
data.s <- filter(data, Date == "1/2/2007" | Date == "2/2/2007")

# Load lubridate package for changing dates format
library(lubridate)
# Change Date from "dd/mm/yyyy" (factor) to "yyyy-mm-dd" (POSIXct)
data.s[, 1] <- dmy(data.s$Date)

# delete full data set
rm(data)

# Create variables with fill date and time
full.time <- paste(data.s$Date, data.s$Time)

# Chande Time on POSIXct time
data.s$Time <- strptime(full.time, "%Y-%m-%d %H:%M:%S")

###----------PLOT2--------------###

# Set parameters of plot. cex.lab - size of labels
par(mfrow = c(1, 1), bg = "transparent", cex = 0.8, cex.lab = 1, 
    oma = c(0, 1, 0, 1))
# plot with titles and labels
plot(data.s$Time, data.s$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power(kilowatts)")
# Saving plot from screen device to png (file device)
dev.copy(png, file = "./plot2.png", width = 480, height = 480)
# DON'T FORGET! Close Graphics Device
dev.off()