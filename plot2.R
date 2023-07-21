#Libraries
library(dplyr)
library(data.table)
library(ggplot2)

#Read the data

rawdata <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

#Give format to Dates columns and extract the selected dates

rawdata$Date <- as.Date(rawdata$Date, format = "%d/%m/%Y")

days <- c("2007-02-01","2007-02-02" )
data<- rawdata %>% filter(Date %in% as.Date (days))


#Give porper format to the rest of the variables

data$Time <- as.ITime (data$Time)
data[,3:9] <- sapply(data[,3:9], as.numeric)

#Create a variable that tells date and time together and 

data$date_time <- as.POSIXct(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

#Exploratory graphics


png("plot2.png", width = 480, height = 480, units = "px")

ggplot(data, aes(x = date_time, y = Global_active_power)) +
        geom_line (size = 1) +
        labs(y = "Global Active Power (kilowatts)", x="")+
        scale_x_datetime(date_labels = "%b %d\n%A", date_breaks = "1 day")

dev.off()
