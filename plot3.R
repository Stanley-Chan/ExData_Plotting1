library("data.table")

##Download the source datafile
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("hh_power_consumption.zip")) {
		download.file(fileurl, "./hh_power_consumption.zip")
}

##Unzip file
if (!file.exists("household_power_consumption.txt")) {
		unzip("./hh_power_consumption.zip") 
}

##Load from file to dataset
alldata <- fread("./household_power_consumption.txt", na.strings="?")

##Subset data to target dataset
plotdata <- alldata[grep("^1/2/2007$|^2/2/2007$", alldata$Date),]

##Convert String to date
x <- paste(plotdata$Date, plotdata$Time)
plotdata$Time <- as.POSIXct(x,format="%d/%m/%Y %H:%M:%S")
plotdata$Date <- as.Date(plotdata$Date, "%d/%m/%Y")

##Plot histogram with Graphics device for PNG
png("plot3.png", width = 480, height = 480)

with(plotdata, plot(Time, Sub_metering_1, type = "l", xlab = "", ylab="Engergy Sub Metering"))
with(plotdata, lines(Time, Sub_metering_2, col="red")) 
with(plotdata, lines(Time, Sub_metering_3, col="blue")) 

##Set Legend
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()