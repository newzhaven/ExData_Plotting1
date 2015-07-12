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
png(file = "plot1.png")
# plotting plot1
hist(hpc$Global_active_power, xlab = "Global Active Power (kilowatts)", 
     col = "red", main = "Global Active Power")
dev.off()
