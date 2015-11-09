library(dplyr)
library(lubridate)

rawData <- read.csv2(
    "household_power_consumption.txt", sep=";", na.strings=c("?", 0), stringsAsFactors = F
)
rawData$Date <- dmy(rawData$Date)
df <- filter(rawData, Date >= ymd("2007-02-01"), Date <= ymd("2007-02-02"))
rm(rawData)

# change other types
df$Global_active_power <- as.numeric(df$Global_active_power)
df$DateTime <- ymd_hms(paste(df$Date, df$Time))
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)
df$Voltage <- as.numeric(df$Voltage)
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)

# have to set locale because I am on a german system
Sys.setlocale("LC_TIME", "C")

# plot
png(file="plot4.png")
par(mfrow=c(2,2))
with(df, {
    
    # plot 1
    plot(DateTime, Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)")
    lines(DateTime, Global_active_power)
    
    # plot 2
    plot(DateTime, Voltage, type="n", xlab="datetime", ylab="Voltage")
    lines(DateTime, Voltage)
    
    # plot 3
    plot(DateTime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
    lines(DateTime, Sub_metering_1)
    lines(DateTime, Sub_metering_2, col="red")
    lines(DateTime, Sub_metering_3, col="blue")
    legend(
        "topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        lty=c(1,1,1), col=c("black", "red", "blue"), bty="n"
    )

    # plot 4
    plot(DateTime, Global_reactive_power, type="n", xlab="datetime")
    lines(DateTime, Global_reactive_power)
    
})
dev.off()