setwd("C:/Users/Jrronal Ramos/Documents/ExData_Plotting1")

library(dplyr)

power_data <- read.table(file = "household_power_consumption.txt", sep = ";", header = TRUE)

head(power_data)

power_data <- power_data[power_data != "?", ]

power_data <- mutate(power_data, date_time = paste(Date, Time, sep = " "))

power_data$date_time = strptime(power_data$date_time, "%d/%m/%Y %H:%M:%S")

power_data$Date = strptime(power_data$Date, "%d/%m/%Y")

str(power_data)

Filtered_data <- filter(power_data, date_time >= "2007-02-01" & Date <= "2007-02-02")

columnas <- names(Filtered_data)

Filtered_data$Global_active_power = as.numeric(Filtered_data$Global_active_power)
Filtered_data$Global_reactive_power = as.numeric(Filtered_data$Global_reactive_power)
Filtered_data$Voltage = as.numeric(Filtered_data$Voltage)
Filtered_data$Global_intensity = as.numeric(Filtered_data$Global_intensity)
Filtered_data$Sub_metering_1 = as.numeric(Filtered_data$Sub_metering_1)
Filtered_data$Sub_metering_2 = as.numeric(Filtered_data$Sub_metering_2)
Filtered_data$Sub_metering_3 = as.numeric(Filtered_data$Sub_metering_3)


### Plot 1

hist(Filtered_data$Global_active_power, col = "red", main = "Global Active Power By RR", xlab = "Global Active Power (Kilowatts)")

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
### Plot 2



with(Filtered_data, plot(date_time, Global_active_power, type = "l", ylab = "Global Active Power (Kilowatts) By RR", xlab = ""))

dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()

### Plot 3

with(Filtered_data, {
        plot(date_time, Sub_metering_1,  type="l", ylab="Global Active Power (kilowatts)", xlab="")
        lines(date_time, Sub_metering_2,col='Red')
        lines(date_time, Sub_metering_3, col='Blue')
})
        
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
 
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

### Plot 4


par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(Filtered_data, {
        plot(date_time, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
        plot(date_time, Voltage, type="l", ylab="Voltage (volt)", xlab="")
        plot(date_time, Sub_metering_1, type="l", ylab="Global Active Power (kilowatts)", xlab="")
        lines(date_time, Sub_metering_2,col='Red')
        lines(date_time, Sub_metering_3,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(date_time, Global_reactive_power, type="l", ylab="Global Rective Power (kilowatts)",xlab="")
})


dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
