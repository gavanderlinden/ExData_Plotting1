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
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)

# have to set locale because I am on a german system
Sys.setlocale("LC_TIME", "C")

# plot
png(file="plot3.png")
with(df, {
    plot(DateTime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
    lines(DateTime, Sub_metering_1)
    lines(DateTime, Sub_metering_2, col="red")
    lines(DateTime, Sub_metering_3, col="blue")
    legend(
        "topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        lty=c(1,1,1), col=c("black", "red", "blue")
    )
})
dev.off()
