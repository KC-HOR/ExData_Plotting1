plot4<- function(){ 
      ### Read the data and clean it up 
      first_line <- read.table("Exploratory Data Analysis/household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE, nrows = 1)
      METER      <- read.table("Exploratory Data Analysis/household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE, skip = 1, na.strings = "?",
                               colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
      colnames(METER) <- first_line 
      
      #combine Date and Time columns
      METER <- transform(METER, DATETIME = paste(Date,Time, sep = " "))
      ##convert the Date char variable to a Date class
      METER$Date <- as.Date(METER$Date, format = "%d/%m/%Y")
      ## subset the dates as required by the course submission
      METER<- METER[METER$Date >= "2007-02-01" & METER$Date <= "2007-02-02",]
      #create a new column of class Posixlt - we'll be using this later as time axis
      METER$DATETIME <- strptime(METER$DATETIME, format = "%d/%m/%Y %H:%M:%S")
      
      #Plot !
      png(filename = "plot4.png", width = 480,height = 480)
      par(mfrow = c(2,2))
      par(mar = c(4,4,2,2))
      plot(METER$DATETIME,METER$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)") # initialize the plot without any points
      lines(METER$DATETIME,METER$Global_active_power, type = "l") # plot the line graph
      plot(METER$DATETIME,METER$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
      plot(METER$DATETIME,METER$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
      legend("topright", legend = c("Sub metering 1","Sub metering 2","Sub metering 3"), lty = c(1,1,1), col = c("black","red","blue"), cex = 0.8)
      lines(METER$DATETIME,METER$Sub_metering_1, type = "l", col = "black")
      lines(METER$DATETIME,METER$Sub_metering_2, type = "l", col = "red")
      lines(METER$DATETIME,METER$Sub_metering_3, type = "l", col = "blue")
      plot(METER$DATETIME,METER$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_Reactive_Power")
      dev.off()

}