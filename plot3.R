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


png("plot3.png", width = 480, height = 480, units = "px")

ggplot(data, aes(x = date_time)) +
        geom_line (aes(y= Sub_metering_1, color = "Sub_metering_1")) +
        geom_line (aes(y= Sub_metering_2, color = "Sub_metering_2")) +
        geom_line (aes(y= Sub_metering_3, color = "Sub_metering_3") )+
        labs(y = "Energy sub metering", x="", color= "")+
        scale_x_datetime(date_labels = "%b %d\n%A", date_breaks = "1 day")+
        scale_color_manual(values = c("Sub_metering_1"="black", "Sub_metering_2"="red", "Sub_metering_3"="blue"), labels = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) +
        theme_minimal()+
        theme(legend.position = "top") 

dev.off()
