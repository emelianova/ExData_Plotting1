# Preparing data
if (!file.exists("household_power_consumption.txt")) {
        URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(URL, destfile="household_power_consumption.zip")
        unzip("household_power_consumption.zip")
}
library(data.table)
DT<- fread("household_power_consumption.txt", sep=";", header=F,
           na.strings="[?]", nrow=2880, skip="1/2/2007", stringsAsFactors=F)
header<- unlist(read.table("household_power_consumption.txt", sep=";", 
                           header=F, nrow=1, stringsAsFactors=F))
setnames(DT, header)
DT[, `:=` (datetime=as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"),
           Date=NULL,
           Time=NULL)]

# here comes the actual plot:
png("plot4.png")
par(mfcol=c(2,2))
attach(DT)
plot(datetime, Global_active_power, 
     type="l", ylab="Global Active Power", xlab="")
plot(datetime, Sub_metering_1, 
     type="l", ylab="Energy sub metering", xlab="")
lines(datetime, Sub_metering_2, col="red")
lines(datetime, Sub_metering_3, col="blue")
plot(datetime, Voltage, type="l")
plot(datetime, Global_reactive_power, type="l")
dev.off()