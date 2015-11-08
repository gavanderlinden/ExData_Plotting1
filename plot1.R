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

# plot
png(file="plot1.png")
with(df, {
    hist(
        Global_active_power, col="red",
        main="Global Active Power", xlab="Global Active Power (kilowatts)"
    )
})
dev.off()
