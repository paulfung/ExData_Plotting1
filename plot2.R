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

# plot
png(filename="plot2.png", width=480, height=480)

plot(consumption$DateTime, consumption$Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)")
lines(consumption$DateTime, consumption$Global_active_power)

dev.off()
