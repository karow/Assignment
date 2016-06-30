library(ggplot2)

# Reads dataset into R 
data <- read.table(file = 'household_power_consumption.txt', sep = ';', header = T, na.strings = '?')

# Converts Date variable into Date class and adds a colummn called DateTime as POSIXlt 
data$Date <- as.Date(data$Date, format = '%d/%m/%Y')
data$DateTime <- strptime(paste(data$Date, data$Time), format = '%Y-%m-%d %H:%M:%S')

# Subsetting the dataset (2007-02-01 to 2007-02-02)
subdata <- subset(data, subset = Date >= '2007-02-01' & Date < '2007-02-03')

# Plot 2: Time over Global Active Power
plot2 <- ggplot(data=subdata, aes(x=DateTime, y=Global_active_power)) +
  geom_line() +
  xlab('') +
  ylab('Global Active Power (kilowatts)') +
  scale_x_datetime(date_labels = '%a', date_breaks = '1 day')
ggsave(file='Plot2.png', width = 6.4, height = 6.4, unit = 'in')