
# read data 
setwd('/Users/fengw/study/datasciencecoursera/ExploratoryDataAnalysis/course1Project')

infile <- "household_power_consumption.txt"
zipfile <- "household_power_consumption.zip"
if (!file.exists(infile)) { 
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url,zipfile,method='curl') 
  unzip(zipfile) 
}

data = read.table(infile,sep=';',header=T, na.strings="?")
data$Time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, "%d/%m/%Y")

startDate = as.Date("2007-02-01")
endDate = as.Date("2007-02-02")
data2 = data$Date
subset = data[dates2>=startDate&dates2<=endDate,]

# Plot1 
png("plot1.png", width=480, height=480)
with(subset, hist(Global_active_power,col='red',main="Global Active Power", xlab="Global Active Power (kilowatts)"))
dev.off()

# plot 2
png("plot2.png", width=480, height=480)
plot(subset$Time, subset$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

# plot 3
png("plot3.png", width=480, height=480)
plot(subset$Time,subset$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
lines(subset$Time,subset$Sub_metering_2,col="red")
lines(subset$Time,subset$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="l",col=c("black","red","blue"),lwd=2,cex=0.7)
dev.off()

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