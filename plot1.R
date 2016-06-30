library(ggplot2)

# Reads dataset into R 
data <- read.table(file = 'household_power_consumption.txt', sep = ';', header = T, na.strings = '?')

# Converts Date variable into Date class and adds a colummn called DateTime as POSIXlt 
data$Date <- as.Date(data$Date, format = '%d/%m/%Y')
data$DateTime <- strptime(paste(data$Date, data$Time), format = '%Y-%m-%d %H:%M:%S')

# Subsetting the dataset (2007-02-01 to 2007-02-02)
subdata <- subset(data, subset = Date >= '2007-02-01' & Date < '2007-02-03')

# Plot 1: Globa Active Power
plot1 <- ggplot(data=subdata, aes(x=Global_active_power)) +
  geom_histogram(binwidth = 0.4, fill='Red', colour='Black') +
  xlab('Global Active Power (kilowatts)') +
  ylab('Frequency') +
  ggtitle('Global Active Power') +
  scale_y_continuous(breaks = c(0, 200, 400, 600, 800, 1000, 1200))
ggsave(file='Plot1.png', width = 6.4, height = 6.4, unit = 'in')