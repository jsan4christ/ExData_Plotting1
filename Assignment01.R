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
hhpd$Time <- strptime(hhpd$Time,format = "%H:%M:%S")
hhpd_r <- subset(hhpd,hhpd$Date >= "2007-02-01" & hhpd$Date <= "2007-02-02" )

#Plot1
png(filename = "repo/ExData_Plotting1/figure/Plot1.png", width = 480, height = 480)
hist(hhpd_r$Global_active_power, col = "red", xlab = "Global Active Power (Kilowatts)", main = "Global Active Power")
dev.off()

#Plot2
d2 <- subset(hhpd,hhpd$Date >= "2007-02-01" & hhpd$Date <= "2007-02-02" )
d2$DateTime <- strptime(paste(d2$Date, d2$Time), "%Y-%m-%d %H:%M:%S")
png(filename = "repo/ExData_Plotting1/figure/Plot2.png", width = 480, height = 480)
with(d2, plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.off()

#Plot3
d3  <- subset(hhpd,hhpd$Date >= "2007-02-01" & hhpd$Date <= "2007-02-02" )
d3$DateTime <- strptime(paste(d3$Date, d3$Time), "%Y-%m-%d %H:%M:%S")

#subset for plotting
d31 <- subset(d3, select = c("DateTime","Sub_metering_1"))
d31$sm <- 1
names(d31)[3] <- "sm"
d32 <- subset(d3, select = c("DateTime","Sub_metering_2"))
d32$sm <- 2
names(d32)[2] <- "Sub_metering"
d33 <- subset(d3, select = c("DateTime","Sub_metering_3"))
d33$sm <- 3
names(d33)[2] <- "Sub_metering"

smc <- rbind(d31,d32,d33)
png(filename = "repo/ExData_Plotting1/figure/Plot3.png", width = 480, height = 480)
plot(smc$DateTime, smc$Sub_metering, type = "n", ylab = "Energy Sub Metering", xlab = "")
points(smc$DateTime[smc$sm == 1], smc$Sub_metering[smc$sm == 1], type = "l", col ="black")
points(smc$DateTime[smc$sm == 2], smc$Sub_metering[smc$sm == 2], type = "l", col = "red")
points(smc$DateTime[smc$sm == 3], smc$Sub_metering[smc$sm == 3], type = "l", col = "blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"),lwd = c(2,2))
dev.off()


#Plot4
png(filename = "repo/ExData_Plotting1/figure/Plot4.png", width = 480, height = 480)

##Change par to allow for multiple graphs
par(mfcol = c(2,2), mar = c(4,4,2,2))

#multi plot1
with(d3, plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power", xlab = ""))

#multi plot 2
plot(smc$DateTime, smc$Sub_metering, type = "n", ylab = "Energy Sub Metering", xlab = "")
points(smc$DateTime[smc$sm == 1], smc$Sub_metering[smc$sm == 1], type = "l", col ="black")
points(smc$DateTime[smc$sm == 2], smc$Sub_metering[smc$sm == 2], type = "l", col = "red")
points(smc$DateTime[smc$sm == 3], smc$Sub_metering[smc$sm == 3], type = "l", col = "blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"),lwd = c(2,2))

#multi plot 3
with(d3, plot(DateTime, Voltage, type = "l", ylab = "Voltage"))

#mult plot4
with(d3, plot(DateTime, Global_reactive_power, type = "l", ylab = "Global Reactive Power"))
dev.off()