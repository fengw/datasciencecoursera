
source("loadzipdata.r")("plot1.png", width=480, height=480)
with(subset, hist(Global_active_power,col='red',main="Global Active Power", xlab="Global Active Power (kilowatts)"))
dev.off()
