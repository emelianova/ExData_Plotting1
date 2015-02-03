# Preparing data. Required packages: data.table
if (!file.exists("household_power_consumption.txt")) {
        URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(URL, destfile="household_power_consumption.zip")
        unzip("household_power_consumption.zip")
}
library(data.table)
DT<- fread("household_power_consumption.txt", sep=";", header=F,
        na.strings="[?]", nrow=2880, skip="1/2/2007", stringsAsFactors=F)
# I've counted in Notepad++ number of matches with "1/2/2007" and "2/2/2007" and
# they turned out to be 1440 both
header<- unlist(read.table("household_power_consumption.txt", sep=";", 
                      header=F, nrow=1, stringsAsFactors=F))
setnames(DT, header)

# here comes the actual plot:
png("plot1.png") # reqired plot dimensions are default, so I don't specify them
hist(DT$Global_active_power, breaks=14, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()