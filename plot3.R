setwd("C:\\Projects\\MDataScience\\Exploratory\\Week1Exercise")

powerConsumptionRaw <- read.table("household_power_consumption.txt",na.strings="?", sep=";", header=T, colClasses = c("character", "character","numeric", "numeric", "numeric" , "numeric" , "numeric" , "numeric" , "numeric" ))

newDateTime <- paste (powerConsumptionRaw$Date, powerConsumptionRaw$Time, sep=" ")
convertedDate <- as.Date(strptime(newDateTime, "%d/%m/%Y %H:%M:%S"))
convertedDateTime <- as.POSIXlt(strptime(newDateTime, "%d/%m/%Y %H:%M:%S"))

powerConsumptionCleansed <- cbind(convertedDate, convertedDateTime, powerConsumptionRaw[c(-1,-2)])

dateRangeAbove <- convertedDate >= as.Date(strptime("2007-02-01", "%Y-%m-%d")) 
dateRangeBelow <- convertedDate <= as.Date(strptime("2007-02-02", "%Y-%m-%d")) 
dateRanges <- dateRangeBelow == TRUE & dateRangeAbove==TRUE 

powerConsumptionFinal <- powerConsumptionCleansed[dateRanges,]


#### Plot 3 #######
png("plot3.png", width=480, height=480)
plot(powerConsumptionFinal$convertedDateTime,powerConsumptionFinal$Sub_metering_1, col="black", xlab="", ylab= "Global Active Power (kilowatts)", type= "l")
lines(powerConsumptionFinal$convertedDateTime,powerConsumptionFinal$Sub_metering_2, col="red")
lines(powerConsumptionFinal$convertedDateTime,powerConsumptionFinal$Sub_metering_3, col="blue")
legend("topright", col=c("black","red","blue"),c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = c('solid', 'solid', 'solid'))

dev.off()
