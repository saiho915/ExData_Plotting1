Sys.setlocale("LC_TIME", "English")
## Load the necessary package
library(dplyr)
## Read the whole dataset
data <- read.table("./data/household_power_consumption.txt", 
                   header = TRUE, sep = ";", na.strings = "?")
## Check columns type
head(data); columnsType <- sapply(data, class); print(columnsType)
## Subset data (1/2/2007 - 2/2/2007)
d <- subset(data, Date %in% c("1/2/2007", "2/2/2007"))
## Transform
d <- mutate(d, datetime = strptime(paste(Date, Time),
                                   format = "%d/%m/%Y %H:%M:%S"))
## Plot and Save
## use png() and dev.off() to construct a png file
png("plot3.png")
with(d, {
  plot(datetime, Sub_metering_1, type = "n",
       xlab = "",
       ylab = "Energy sub metering")
  lines(datetime, Sub_metering_1, type = "l", col = "black")
  lines(datetime, Sub_metering_2, type = "l", col = "red")
  lines(datetime, Sub_metering_3, type = "l", col = "blue")
})
legend("topright", 
       lty = 1,
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
Sys.setlocale("LC_TIME", "")