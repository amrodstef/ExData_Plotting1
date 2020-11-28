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



#Since the OS in here has another language, I needed to change to english
Sys.setlocale("LC_TIME", "English") 
#Calling the 'plot()' function and annotating it's title:
plot(data_sub$Time, as.numeric(as.character(data_sub$Global_active_power)),
     type="l",xlab="", ylab="Global Active Power (kilowatts)")
title(main="Global Active Power Vs Time")

#Saving it into 'plot2.png' file:
dev.copy(png, filename="plot2.png")
#Turning off the plotting device and setting up the default again.
dev.off()
