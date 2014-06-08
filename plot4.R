# import data
consumption <- read.csv2("household_power_consumption.txt", sep=";")

# filter date
dateFilter <- strptime(consumption$Date, "%d/%m/%Y") %in% strptime(c("01/02/2007", "02/02/2007"), "%d/%m/%Y")
consumption <- consumption[dateFilter,]

# combine date and time field and create DateTime column
dateTime <- paste(consumption$Date, consumption$Time)
consumption$DateTime <- strptime(dateTime, "%d/%m/%Y %H:%M:%S")

# convert column data to numeric and filter NA
consumption$Global_active_power <- as.numeric(levels(consumption$Global_active_power))[consumption$Global_active_power]
consumption <- consumption[!is.na(consumption$Global_active_power),]

consumption$Voltage <- as.numeric(levels(consumption$Voltage))[consumption$Voltage]
consumption <- consumption[!is.na(consumption$Voltage),]

consumption$Sub_metering_1 <- as.numeric(levels(consumption$Sub_metering_1))[consumption$Sub_metering_1]
consumption <- consumption[!is.na(consumption$Sub_metering_1),]
consumption$Sub_metering_2 <- as.numeric(levels(consumption$Sub_metering_2))[consumption$Sub_metering_2]
consumption <- consumption[!is.na(consumption$Sub_metering_2),]
consumption$Sub_metering_3 <- as.numeric(levels(consumption$Sub_metering_3))[consumption$Sub_metering_3]
consumption <- consumption[!is.na(consumption$Sub_metering_3),]

consumption$Global_reactive_power <- as.numeric(levels(consumption$Global_reactive_power))[consumption$Global_reactive_power]
consumption <- consumption[!is.na(consumption$Global_reactive_power),]

# plot
png(filename="plot4.png", width=480, height=480)

par(mfrow=c(2,2))

#plot 1
plot(consumption$DateTime, consumption$Global_active_power, type="n", xlab="", ylab="Global Active Power")
lines(consumption$DateTime, consumption$Global_active_power)


#plot 2
plot(consumption$DateTime, consumption$Voltage, type="n", xlab="datetime", ylab="Voltage")
lines(consumption$DateTime, consumption$Voltage)


#plot 3
par(col="BLACK")
plot(consumption$DateTime, consumption$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(consumption$DateTime, consumption$Sub_metering_1)

par(col="RED")
lines(consumption$DateTime, consumption$Sub_metering_2)

par(col="BLUE")
lines(consumption$DateTime, consumption$Sub_metering_3)

par(col="BLACK")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("BLACK", "RED", "BLUE"), lty=1, bty="n")


#plot 4
plot(consumption$DateTime, consumption$Global_reactive_power, type="n", xlab="datetime", ylab="Global_reactive_power")
lines(consumption$DateTime, consumption$Global_reactive_power)


dev.off()