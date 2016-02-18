source("loadzipdata.r")

# plot 2
png("plot2.png", width=480, height=480)
plot(subset$Time, subset$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()