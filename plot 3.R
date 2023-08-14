library(readr)
library( stringr)
library(dplyr)
setwd("C:/Users/user/Documents/WIS/Master/curses/R cor")
file <- "household_power_consumption.txt"
power <- read_csv2( file = file )
p <- str_subset(string = power$Date, pattern = "^1/2/2007$|^2/2/2007$")
filtered_power <- power %>%
  filter(Date %in% p)
filtered_power$Global_active_power = as.numeric(filtered_power$Global_active_power)
filtered_power <- filtered_power[!is.na(filtered_power$Global_active_power), ]

filtered_power$Date <- as.Date(filtered_power$Date, format = "%d/%m/%Y")
filtered_power$Day = ifelse(filtered_power$Date == "2007-02-01","thu","fri")
filtered_power$DateTime <- as.POSIXct(paste(filtered_power$Date, filtered_power$Time), format = "%Y-%m-%d %H:%M:%S")

midnight_times <- filtered_power$DateTime[format(filtered_power$DateTime, "%H:%M:%S") == "00:00:00"]
Sys.setlocale("LC_TIME", "en_US.UTF-8")
specific_date <- as.POSIXct("2007-02-03 00:00:00")


png("plot3.png", width = 480, height = 480)
plot(filtered_power$DateTime, filtered_power$Sub_metering_1, type = "l", 
     main = "Sub-Metering Data", xlab = "Date and Time", ylab = "Enrgy Sub-Metering",xaxt = "n")

lines(filtered_power$DateTime, filtered_power$Sub_metering_2, col = "red")
lines(filtered_power$DateTime, filtered_power$Sub_metering_3, col = "blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)

axis(1, at = midnight_times, labels = format(midnight_times, "%a"))

axis(1, at = specific_date, labels = format(specific_date, "%a"), col.axis = "black")

dev.off()
