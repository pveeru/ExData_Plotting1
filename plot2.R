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
#Create Data frame of the DateTime and Global Active Power
finalData<-data.frame(Dt=dtReformat,GAP=RawData$Global_active_power)

#Create png file
png(file="plot2.png",width = 480, height = 480)
#Create the plot
plot(finalData$Dt,finalData$GAP, type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()#turn off graphic device