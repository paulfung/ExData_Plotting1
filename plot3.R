# import data
consumption <- read.csv2("household_power_consumption.txt", sep=";")

# filter date
dateFilter <- strptime(consumption$Date, "%d/%m/%Y") %in% strptime(c("01/02/2007", "02/02/2007"), "%d/%m/%Y")
consumption <- consumption[dateFilter,]

# combine date and time field and create DateTime column
dateTime <- paste(consumption$Date, consumption$Time)
consumption$DateTime <- strptime(dateTime, "%d/%m/%Y %H:%M:%S")

# convert column data to numeric and filter NA
consumption$Sub_metering_1 <- as.numeric(levels(consumption$Sub_metering_1))[consumption$Sub_metering_1]
consumption <- consumption[!is.na(consumption$Sub_metering_1),]
consumption$Sub_metering_2 <- as.numeric(levels(consumption$Sub_metering_2))[consumption$Sub_metering_2]
consumption <- consumption[!is.na(consumption$Sub_metering_2),]
consumption$Sub_metering_3 <- as.numeric(levels(consumption$Sub_metering_3))[consumption$Sub_metering_3]
consumption <- consumption[!is.na(consumption$Sub_metering_3),]

# plot
png(filename="plot3.png", width=480, height=480)

par(col="BLACK")
plot(consumption$DateTime, consumption$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(consumption$DateTime, consumption$Sub_metering_1)

par(col="RED")
lines(consumption$DateTime, consumption$Sub_metering_2)

par(col="BLUE")
lines(consumption$DateTime, consumption$Sub_metering_3)

par(col="BLACK")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("BLACK", "RED", "BLUE"), lty=1)

dev.off()