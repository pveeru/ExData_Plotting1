#!!!This script assumes the Raw data has been downloaded and unzipped to the working directory!!!

#Create a file object for raw data
allFile <- file("household_power_consumption.txt", "r")

#create a 2nd subfile containing only the dates we are interested in i.e. 1/2/2007 and 2/2/2007
cat(grep("(^Date)|(^[1|2]/2/2007)",readLines(allFile), value=TRUE), sep="\n", file="subFile.txt")
close(allFile)

#Read the subFile
RawData <- read.csv("subFile.txt",sep=";")
#Create temp variable for date formatting
tmpDtTm <-paste(RawData$Date,RawData$Time)
#Reformat Dates with time
dtReformat <- strptime(tmpDtTm,"%d/%m/%Y %H:%M:%S")
#Create Data frame of the DateTime and the 3 Energy sub-metering data
finalData<-data.frame(Dt=dtReformat,GAP=RawData$Global_active_power,Volt=RawData$Voltage,SM1=RawData$Sub_metering_1,SM2=RawData$Sub_metering_2,SM3=RawData$Sub_metering_3,GRP=RawData$Global_reactive_power)

#Create png file
png(file="plot4.png",width = 480, height = 480)

par(mfrow = c(2, 2))
#Create Global Active power plot
plot(finalData$Dt,finalData$GAP, type="l",xlab="",ylab="Global Active Power (kilowatts)")

#Create Voltage plot
plot(finalData$Dt,finalData$Volt, type="l",xlab="datetime",ylab="Voltage")

#Create the sub-metering plot
plot(finalData$Dt,finalData$SM1, type="l",xlab="",ylab="Energy sub metering")
lines(finalData$Dt,finalData$SM2, type="l",col="blue")
lines(finalData$Dt,finalData$SM3, type="l",col="red")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = 1,col=c("black","blue","red"), pt.cex=1,cex=0.5)

#Create Global Reactive power plot
plot(finalData$Dt,finalData$GRP, type="l",xlab="datetime",ylab="Global_reactive_power")

par(las = 0)

dev.off()#turn off graphic device