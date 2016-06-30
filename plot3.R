library(ggplot2)

# Reads dataset into R 
data <- read.table(file = 'household_power_consumption.txt', sep = ';', header = T, na.strings = '?')

# Converts Date variable into Date class and adds a colummn called DateTime as POSIXlt 
data$Date <- as.Date(data$Date, format = '%d/%m/%Y')
data$DateTime <- strptime(paste(data$Date, data$Time), format = '%Y-%m-%d %H:%M:%S')

# Subsetting the dataset (2007-02-01 to 2007-02-02)
subdata <- subset(data, subset = Date >= '2007-02-01' & Date < '2007-02-03')

# Plot 3: Time over Energy sub metering
plot3 <- ggplot(data=subdata, aes(x=DateTime)) +
  geom_line(aes(y=Sub_metering_1, color='Sub_metering_1')) +
  geom_line(aes(y=Sub_metering_2, color='Sub_metering_2')) +
  geom_line(aes(y=Sub_metering_3, color='Sub_metering_3')) +
  xlab('') +
  ylab('Energy sub metering') +
  scale_x_datetime(date_labels = '%a', date_breaks = '1 day') +
  scale_color_manual(name='',values=c('Sub_metering_1'='Black', 'Sub_metering_2'='Red', 'Sub_metering_3'='Blue')) +
  theme(legend.justification=c(1,1), legend.position=c(1,1), legend.title=element_blank())
ggsave(file='Plot3.png', width = 6.4, height = 6.4, unit = 'in')