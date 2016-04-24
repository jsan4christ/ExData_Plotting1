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

