## Load in data
new_file <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";")
trial <- new_file[new_file$Date == "1/2/2007",]
trial <- rbind(trial, new_file[new_file$Date == "2/2/2007",])

## Subset data and make plot 1 according to demands
plotdata <- as.numeric(trial$Global_active_power)
hist(plotdata, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()


## Make plot 2
trial$Date <- as.Date(trial$Date, format = "%d/%m/%Y")
trial["newTime"] <- paste(trial$Date, trial$Time)
plot(as.POSIXct(trial$newTime), trial$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()

## Make Plot 3
# Convert values to character first and then numeric them, otherwise it's easy to get into trouble
trial$Sub_metering_1 <- as.numeric(as.character(trial$Sub_metering_1))
trial$Sub_metering_2 <- as.numeric(as.character(trial$Sub_metering_2))
trial$Sub_metering_3 <- as.numeric(as.character(trial$Sub_metering_3))

# Make graphs in the same plot
plot(as.POSIXct(trial$newTime), trial$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(as.POSIXct(trial$newTime), trial$Sub_metering_2, type = "l", col = "red")
lines(as.POSIXct(trial$newTime), trial$Sub_metering_3, type = "l", col = "blue")
legend("topright", col = c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty = 1, lwd = c(1,1))
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()

## Make plot 4
par(mfrow=c(2,2))
#1
plot(as.POSIXct(trial$newTime), trial$Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
#2
trial$Voltage <- as.numeric(as.character(trial$Voltage))
plot(as.POSIXct(trial$newTime), trial$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
#3
#cex tunes the size of legend to fit in after shrinking of the original graph
plot(as.POSIXct(trial$newTime), trial$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(as.POSIXct(trial$newTime), trial$Sub_metering_2, type = "l", col = "red")
lines(as.POSIXct(trial$newTime), trial$Sub_metering_3, type = "l", col = "blue")

#4
trial$Global_reactive_power <- as.numeric(as.character(trial$Global_reactive_power))
plot(as.POSIXct(trial$newTime), trial$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
