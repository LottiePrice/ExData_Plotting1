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
#(Not used for this graph, but used in the others.)
hsub$DateTime = chron(dates=as.character(hsub$Date), 
                      times=as.character(hsub$Time),
                      format = c("d/m/Y", "h:m:s"))
hsub$weekday = weekdays(hsub$DateTime)
hsub$hour = hours(hsub$DateTime)

}

#draw the histogram showing global active power.
#I define it as a function here so I can reuse it in Plot4. 

plot1 = function(){
  hist(hsub$Global_active_power,
             main="Global Active Power",
             xlab = "Global Active Power (kilowatts)",
             col = "red",
             freq= TRUE,
             bg="transparent")
}
#here is the actual drawing to a file.
png("Plot1.png", width=480, height=480, units="px", bg= "transparent")
plot1()
dev.off()

