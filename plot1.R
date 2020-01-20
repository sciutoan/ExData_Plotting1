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

#Create Plot 1
hist(data$Global_active_power, main='Global Active Power', xlab = 'Global Active Power (kilowatts)', col='red')

#Save Plot
dev.copy(png,'plot1.png', width=500, height=500)
dev.off()