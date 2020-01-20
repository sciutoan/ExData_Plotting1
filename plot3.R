#Load and Clean Data
data <- read.table('household_power_consumption.txt', header = TRUE, sep=';', na.strings='?',colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
data$Date <- as.Date(data$Date, '%d/%m/%Y')
data <- subset(data,Date >= as.Date('2007-2-1') & Date <= as.Date('2007-2-2'))
data <- data[complete.cases(data),]
DateAndTime <- paste(data$Date, data$Time)
DateAndTime <- setNames(DateAndTime, 'DateTime')
data <- data[ ,!(names(data) %in% c('Date','Time'))]
data <- cbind(DateAndTime, data)
data$DateAndTime <- as.POSIXct(DateAndTime)

#Create Plot 3
with(data, 
  {
  plot(Sub_metering_1~DateAndTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateAndTime,col='Red')
  lines(Sub_metering_3~DateAndTime,col='Blue')
  })
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Save Plot
dev.copy(png,'plot3.png', width=500, height=500)
dev.off()