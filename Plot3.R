#setwd("ExploratoryDataAnalysis")
library(chron)
library(dplyr)
library(reshape2)


#read in the table and reduce to the subset (Feb 1-2, 2007)
#Skip this step if it's already loaded.
if(!exists("hpc")){
  hpc = read.table("household_power_consumption.txt", sep=";", 
                   header=TRUE,
                   na.strings= "?")
  hsub = subset(hpc, Date=="1/2/2007"|Date=="2/2/2007")


#Change the dates from strings to actual dates.
#find the day of the week.
hsub$DateTime = chron(dates=as.character(hsub$Date), 
                      times=as.character(hsub$Time),
                      format = c("d/m/Y", "h:m:s"))
hsub$weekday = weekdays(hsub$DateTime)
hsub$hour = hours(hsub$DateTime)
}

#draw the line graph 
#To get an exact match, I can't use the dev.copy function. 
#As with plot1, I'm defining the graph as a function so I can reuse the code in plot4.

plot3= function(boxtype = "n"){
plot(hsub$Sub_metering_1,
     col= "black",
     type = "l",
     main="",
     ylab = "Energy sub metering",
     xlab = "",
     xaxt = "n",
     bg="transparent")
points(hsub$Sub_metering_2,
     col= "red",
     type = "l")
points(hsub$Sub_metering_3,
     col= "blue",
     type= "l")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty= 1,
       bty = boxtype)
axis(side=1, at = c(1, 1440, 2880), labels = c("Thu", "Fri", "Sat"))
}

png("Plot3.png", width=480, height=480, units="px", bg= "transparent")
plot3("o")
dev.off()
