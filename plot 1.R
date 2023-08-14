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

png("plot1.png", width = 480, height = 480)

hist(filtered_power$Global_active_power, main ="Global Active power" ,xlab = "Global active power (kilowatts)",col = "red")

dev.off()
