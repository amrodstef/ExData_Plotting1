#There was no link to download the file from the web, do I made it manually.
#The file is in the project folder, so, it's not necessary to set the working directory
#But it'll be necessary if you don't already have one set.

# Read a .txt file, named "household_power_consumption.txt"
my_data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
names(my_data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage",
                    "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

#I read the whole file and then I will subset it into the dates 
#2007-02-01 and 2007-02-02 as says the instructions.

data_sub <- subset(my_data,my_data$Date == "1/2/2007" | my_data$Date == "2/2/2007")


#Transforming Date and Time variables into 'Date' and 'POSIXlt' classes:

data_sub$Date <- as.Date(data_sub$Date, format = "%d/%m/%Y")
data_sub$Time <- strptime(data_sub$Time, format = "%H:%M:%S")
data_sub[1:1440,"Time"] <- format(data_sub[1:1440, "Time"], "2007-02-01 %H:%M:%S")
data_sub[1441:2880,"Time"] <- format(data_sub[1441:2880, "Time"], "2007-02-02 %H:%M:%S")

#For setting more than one graph in a composition, we need to set a grid 

par(mfrow=c(2,2))
with(data_sub,{
    plot(data_sub$Time, as.numeric(as.character(data_sub$Global_active_power)), type = "l",
         xlab = "", ylab = "Global Active Power")  
    plot(data_sub$Time, as.numeric(as.character(data_sub$Voltage)), 
         type = "l", xlab = "datetime", ylab = "Voltage")
    plot(data_sub$Time, data_sub$Sub_metering_1,type = "n", xlab = "", ylab = "Energy sub metering")
    with(data_sub, lines(Time, as.numeric(as.character(Sub_metering_1))))
    with(data_sub, lines(Time, as.numeric(as.character(Sub_metering_2)), col = "red"))
    with(data_sub, lines(Time, as.numeric(as.character(Sub_metering_3)), col = "blue"))
    legend("topright", lty = 1, col = c("black","red","blue"), 
           legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
    plot(data_sub$Time,as.numeric(as.character(data_sub$Global_reactive_power)), 
         type="l", xlab="datetime", ylab="Global_reactive_power")
})

#Saving it into 'plot4.png' file:
dev.copy(png, filename="plot4.png")
#Turning off the plotting device and setting up the default again.
dev.off()
