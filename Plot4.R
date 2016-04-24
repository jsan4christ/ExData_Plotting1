## Exploratory Data Analysis - Course Project 01 ##

#Create data directory
if(!file.exists("Data")){dir.create("Data")}
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "Data/hhpData.zip") #for other systems, add argument, method = "curl"

if(!file.exists("Data/household_power_consumption.txt")){
      unzip("Data/exdata-data-household_power_consumption.zip", exdir = "Data")
}

hhpd <- read.table("Data/household_power_consumption.txt",header = TRUE, sep = ";", na.strings = "?")
hhpd$Date <- as.Date(hhpd$Date, "%d/%m/%Y")


#Plot4
d4  <- subset(hhpd,hhpd$Date >= "2007-02-01" & hhpd$Date <= "2007-02-02" )
d4$DateTime <- strptime(paste(d3$Date, d3$Time), "%Y-%m-%d %H:%M:%S")

png(filename = "repo/ExData_Plotting1/figure/Plot4.png", width = 480, height = 480)

##Change par to allow for multiple graphs
par(mfcol = c(2,2), mar = c(4,4,2,2))

#multi plot1
with(d4, plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power", xlab = ""))

#multi plot 2
#subset for plotting
d41 <- subset(d4, select = c("DateTime","Sub_metering_1"))
d41$sm <- 1
names(d31)[2] <- "Sub_metering"
d42 <- subset(d4, select = c("DateTime","Sub_metering_2"))
d42$sm <- 2
names(d32)[2] <- "Sub_metering"
d43 <- subset(d4, select = c("DateTime","Sub_metering_3"))
d43$sm <- 3
names(d33)[2] <- "Sub_metering"

smc <- rbind(d41,d42,d43)

plot(smc$DateTime, smc$Sub_metering, type = "n", ylab = "Energy Sub Metering", xlab = "")
points(smc$DateTime[smc$sm == 1], smc$Sub_metering[smc$sm == 1], type = "l", col ="black")
points(smc$DateTime[smc$sm == 2], smc$Sub_metering[smc$sm == 2], type = "l", col = "red")
points(smc$DateTime[smc$sm == 3], smc$Sub_metering[smc$sm == 3], type = "l", col = "blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"),lwd = c(2,2))

#multi plot 3
with(d4, plot(DateTime, Voltage, type = "l", ylab = "Voltage"))

#mult plot4
with(d4, plot(DateTime, Global_reactive_power, type = "l", ylab = "Global Reactive Power"))
dev.off()