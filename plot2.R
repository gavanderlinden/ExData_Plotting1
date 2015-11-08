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

# have to set locale because I am on a german system
Sys.setlocale("LC_TIME", "C")

# plot
png(file="plot2.png")
with(df, {
    plot(DateTime, Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)")
    lines(DateTime, Global_active_power)
})
dev.off()
