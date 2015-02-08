# Preparing data
if (!file.exists("household_power_consumption.txt")) {
        URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(URL, destfile="household_power_consumption.zip")
        unzip("household_power_consumption.zip")
}
library(data.table)
DT<- fread("household_power_consumption.txt", sep=";", 
           na.strings="[?]", nrow=2880, skip="1/2/2007", stringsAsFactors=F)
header<- unlist(read.table("household_power_consumption.txt", sep=";", 
                           header=F, nrow=1, stringsAsFactors=F))
setnames(DT, header)
DT[, `:=` (datetime=as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"),
           Date=NULL,
           Time=NULL)]

# here comes the actual plot:
png("plot3.png")
plot(DT$datetime, DT$Sub_metering_1, 
     type="l", ylab="Energy sub metering", xlab="")
lines(DT$datetime, DT$Sub_metering_2, col="red")
lines(DT$datetime, DT$Sub_metering_3, col="blue")
legend("topright", names(DT)[5:7], lty=1, col=c("black", "red", "blue"), 
       y.intersp=1)
dev.off()