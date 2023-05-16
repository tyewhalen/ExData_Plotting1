# Load packages, unzip file and read comma-delimited data into R, then summarize #
library(readr)
library(dplyr)

energy_data <- read.table(unzip("exdata_data_household_power_consumption.zip", "household_power_consumption.txt"), sep=";", header=TRUE)
head(energy_data)
summary(energy_data)


# Convert date to date class and subset data for 2007-02-01 and 2007-02-02 #
energy_data[['Date']] <- as.Date(energy_data$Date, "%d/%m/%Y")
data_subset <- energy_data[energy_data$Date >= "2007-02-01" & energy_data$Date <= "2007-02-02",]
unique(data_subset$Date)


# Convert other fields to numeric for graphing #
tidy_data <- data_subset %>% mutate_at(c('Global_active_power', 'Global_reactive_power', 'Voltage', 'Global_intensity', 'Sub_metering_1', 'Sub_metering_2'), as.numeric)
summary(tidy_data)


# Merging date and time columns into one #
date_time <- as.POSIXct(paste(tidy_data$Date, tidy_data$Time), format="%Y-%m-%d %H:%M:%S")


# Create first plot - a red histogram #
png(file="C:/Users/tywhalen/Downloads/plot1.png", width=480, height=480)

hist(tidy_data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

dev.off()