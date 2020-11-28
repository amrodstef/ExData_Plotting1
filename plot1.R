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

#Making the 1st plot
#Calling the 'hist()' function:

hist(as.numeric(as.character(data_sub$Global_active_power)),col="red",
     main="Global Active Power",xlab="Global Active Power(kilowatts)")

#Saving the plot into "plot1.png" file. Right after that, turning of the plotting device.
dev.copy(png, filename="plot1.png")
dev.off()
