# import data
consumption <- read.csv2("household_power_consumption.txt", sep=";")

# filter date
dateFilter <- strptime(consumption$Date, "%d/%m/%Y") %in% strptime(c("01/02/2007", "02/02/2007"), "%d/%m/%Y")
consumption <- consumption[dateFilter,]

# convert column data to numeric and filter NA
consumption$Global_active_power <- as.numeric(levels(consumption$Global_active_power))[consumption$Global_active_power]
consumption <- consumption[!is.na(consumption$Global_active_power),]

# plot
png(filename="plot1.png", width=480, height=480)
hist(consumption$Global_active_power, xlab="Global Active Power (kilowatts)", col="RED", main="Global Active Power")
dev.off()
