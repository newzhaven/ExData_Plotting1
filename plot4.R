# assume that having the file placed at the location
filename <- "data/household_power_consumption.txt"

# open a file connection
con <- file(filename)
open(con)

# read column header first
headers <- read.table(con, sep = ";", stringsAsFactors = FALSE, nrow = 1)
headers <- as.character(headers[1,])
# read the content of Date between 2007-02-01 and 2007-02-02
# the desired data starts at the 66637th line
# number of records to read = 2 * 1440 (60*24 records per day)
hpc <- read.table(con, sep = ";", skip = 66636, nrow = 2880, na.strings = "?", 
                  col.names = headers)
close(con)

# convert Date and Time
hpc$Time <- strptime(paste(hpc$Date,hpc$Time), format="%d/%m/%Y %H:%M:%S")
hpc$Date <- as.Date(hpc$Date, format="%d/%m/%Y")

# setting a graphics device
png(file = "plot4.png")

## plotting 
par(mfrow = c(2,2))

# chart1: Global Active Power by time (top-left)
with(hpc, plot(Time, Global_active_power, type = "l", 
               xlab = "", ylab = "Global Active Power"))
# chart2: Voltage by time (top-right)
with(hpc, plot(Time, Voltage, type = "l", xlab = "datetime"))

# chart3: Each Energy sub metering by time (bottom-left)
with(hpc, plot(Time, Sub_metering_1, type = "l", 
               xlab = "", ylab = "Energy sub metering"))
with(hpc, lines(Time, Sub_metering_2, col = "red"))
with(hpc, lines(Time, Sub_metering_3, col = "blue"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col = c("black","red","blue"), lty = 1, bty = "n")

# chart4: Global reactive power by time (bottom-right)
with(hpc, plot(Time, Global_reactive_power, type = "l", xlab = "datetime"))

dev.off()
