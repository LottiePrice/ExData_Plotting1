#setwd("ExploratoryDataAnalysis")
library(chron)
library(dplyr)
library(reshape2)

#Load in the previous plots 
#source("Plot1.R")
source("Plot2.R")
source("Plot3.R")

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

#Make up the voltage plot, voltage vs. datetime.
voltage_plot = function(){
  plot(hsub$Voltage,
       col= "black",
       type = "l",
       main="",
       ylab = "Voltage",
       xlab = "datetime",
       xaxt = "n",
       bg="transparent")
  axis(side=1, at = c(1, 1440, 2880), labels = c("Thu", "Fri", "Sat"))
}

#Make up the Global_reactive_power plot
global_reactive_power_plot = function(){
  plot(hsub$Global_reactive_power,
       col= "black",
       type = "l",
       main="",
       ylab = "Global_reactive_power",
       xlab = "datetime",
       xaxt = "n",
       bg="transparent")
  axis(side=1, at = c(1, 1440, 2880), labels = c("Thu", "Fri", "Sat"))
}

#Put all the plots together on the same page

png("Plot4.png", width=480, height=480, units="px", bg= "transparent")

par(mfrow = c(2,2),
    oma = c(0,0,0,0),
    mar = c(4,4,4,2))
plot2()
voltage_plot()
plot3()
global_reactive_power_plot()

dev.off()
