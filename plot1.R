plot1 <- function() {
  
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
  
    ### Plot!
    png(filename = "plot1.png", width = 480,height = 480)
    par(mfrow = c(1,1))
    hist(METER$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
    dev.off()

}