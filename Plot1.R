#Reading the dataset
library(dplyr)
library(data.table)
pwr_data<-data.table(read.delim('household_power_consumption.txt',sep = ";",header = TRUE,
                                na.strings = "?", 
                                colClasses = c('character','character','numeric',
                                               'numeric','numeric','numeric','numeric',
                                               'numeric','numeric')))
pwr_data$Date <- as.Date( as.character(pwr_data$Date), "%d/%m/%Y")
pwr_data <- subset(pwr_data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
pwr_data <- pwr_data[complete.cases(pwr_data),]
## Combine Date and Time column
dateTime <- paste(pwr_data$Date, pwr_data$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
pwr_data <- pwr_data[ ,!(names(pwr_data) %in% c("Date","Time"))]

## Adding DateTime variable
pwr_data <- cbind(dateTime, pwr_data)

## Formatting dateTime variable
pwr_data$dateTime <- as.POSIXct(dateTime)

## Plotting the histogram
hist(pwr_data$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")