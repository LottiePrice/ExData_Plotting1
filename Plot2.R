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
#Reduce the subset to the only relevant columns: weekday, hour, Global_active_power
graphSubset = select(hsub, weekday, hour, Global_active_power)


#draw the line graph 
#To get an exact match, I can't use the dev.copy function. 
#As with plot1, I'm defining the graph as a function so I can reuse the code in plot4.
#Note that I have to pass in the title since I need it for plot2 but not for plot4

plot2 = function(title = "", ylabel = "Global Active Power"){
  plot(graphSubset$Global_active_power,
       type = "l",
       main = title,
       ylab = ylabel,
       xlab = "",
       xaxt = "n",
       bg="transparent")
  axis(side=1, at = c(1, 1440, 2880), labels = c("Thu", "Fri", "Sat"))
  
}


png("Plot2.png", width=480, height=480, units="px", bg= "transparent")

plot2("Global Active Power", "Global Active Power (kilowatts)")
dev.off()



#-------------------------------
# Collated data
#
# (This gives a smoother graph)
#--------------------------------
#collate the data by day of week & time
#Do I need the sum or the mean?

#melted= melt(graphSubset, id.vars= c("weekday", "hour"))
#grouped = group_by(melted, weekday, hour, variable)
#summary = summarise(grouped,  mean = mean(value))


#plot(summary$mean,
#     type = "l",
#      main="Global Active Power",
#      ylab = "Global Active Power (kilowatts)",
#      xlab = "",
#      xaxt = "n",
#      bg="transparent")
