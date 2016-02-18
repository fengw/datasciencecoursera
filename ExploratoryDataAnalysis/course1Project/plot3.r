source("loadzipdata.r")

# plot 3
png("plot3.png", width=480, height=480)
plot(subset$Time,subset$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
lines(subset$Time,subset$Sub_metering_2,col="red")
lines(subset$Time,subset$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="l",col=c("black","red","blue"),lwd=2,cex=0.7)
dev.off()