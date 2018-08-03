#
# first we need to load the dataset
#
path<-getwd()
dataa<-read.table("household_power_consumption.txt",sep=";",head=TRUE,stringsAsFactors=F)
name<-names(dataa)
dataa$Datee<-as.Date(dataa$Date,format="%d/%m/%Y")
library(dplyr)
#
# subset  data from the dates 2007-02-01 and 2007-02-02
#
datasub<-dataa%>%
  filter(Datee=="2007-02-01"|Datee=="2007-02-02")%>%
  mutate(day=weekdays(Datee))

datetime <- strptime(paste(datasub$Date, datasub$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
datasub$Global_active_power<-as.numeric(datasub$Global_active_power)
datasub$Sub_metering_1<-as.numeric(datasub$Sub_metering_1)
datasub$Sub_metering_2<-as.numeric(datasub$Sub_metering_2)
datasub$Sub_metering_3<-as.numeric(datasub$Sub_metering_3)
datasub$Global_reactive_power<-as.numeric(datasub$Global_reactive_power)
datasub$Voltage<-as.numeric(datasub$Voltage)

#
# plot3
#
png("plot3.png",width=480,height=480)
plot(datetime,datasub$Sub_metering_1,xlab="",ylab="Energy per metering",type="l")
lines(datetime,datasub$Sub_metering_2,col="red",type="l")
lines(datetime,datasub$Sub_metering_3,col="blue",type="l")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1))
dev.off()

