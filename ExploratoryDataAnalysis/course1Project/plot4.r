source("loadzipdata.zip") 

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

plot(subset$Time, subset$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

plot(subset$Time, subset$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(subset$Time,subset$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
lines(subset$Time,subset$Sub_metering_2,col="red")
lines(subset$Time,subset$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="l",col=c("black","red","blue"),lwd=2,cex=0.7)

plot(subset$Time, subset$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Voltage")

dev.off()