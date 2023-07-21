#Libraries
library(dplyr)
library(data.table)

#Read the data

rawdata <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

#Give format to Dates columns and extract the selected dates

rawdata$Date <- as.Date(rawdata$Date, format = "%d/%m/%Y")

days <- c("2007-02-01","2007-02-02" )
data<- rawdata %>% filter(Date %in% as.Date (days))


#Give porper format to the rest of the variables

data$Time <- as.ITime (data$Time)
data[,3:9] <- sapply(data[,3:9], as.numeric)

#Exploratory graphics

png("plot1.png", width = 480, height = 480, units = "px")

hist(data$Global_active_power, col="#FF6600", main="", xlab= "Golbal Active Power (kilowatts)")

dev.off()
