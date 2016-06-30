library(ggplot2)

# Reads dataset into R 
data <- read.table(file = 'household_power_consumption.txt', sep = ';', header = T, na.strings = '?')

# Converts Date variable into Date class and adds a colummn called DateTime as POSIXlt 
data$Date <- as.Date(data$Date, format = '%d/%m/%Y')
data$DateTime <- strptime(paste(data$Date, data$Time), format = '%Y-%m-%d %H:%M:%S')

# Subsetting the dataset (2007-02-01 to 2007-02-02)
subdata <- subset(data, subset = Date >= '2007-02-01' & Date < '2007-02-03')

# Plot 1: Globa Active Power
plot1 <- ggplot(data=subdata, aes(x=Global_active_power))
plot1 + geom_histogram(binwidth = 0.4, fill='Red', colour='Black') +
        xlab('Global Active Power (kilowatts)') +
        ylab('Frequency') +
        ggtitle('Global Active Power') +
        scale_y_continuous(breaks = c(0, 200, 400, 600, 800, 1000, 1200))
ggsave(file='Plot1.png', width = 6.4, height = 6.4, unit = 'in')

# Plot 2: Time over Global Active Power
plot2 <- ggplot(data=subdata, aes(x=DateTime, y=Global_active_power)) +
        geom_line() +
        xlab('') +
        ylab('Global Active Power (kilowatts)') +
        scale_x_datetime(date_labels = '%a', date_breaks = '1 day')
ggsave(file='Plot2.png', width = 6.4, height = 6.4, unit = 'in')
        
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

# Plot 4: 4 Plots in One

library(grid)
library(gridExtra)

plot4.1 <- ggplot(data=subdata, aes(x=DateTime, y=Voltage)) +
          geom_line() +
          xlab('datetime') +
          ylab('Voltage') +
          scale_x_datetime(date_labels = '%a', date_breaks = '1 day') +
          scale_y_continuous(breaks = c(234, 238, 242, 246))

plot4.2 <- ggplot(data=subdata, aes(x=DateTime, y=Global_reactive_power)) +
          geom_line() +
          xlab('datetime') +
          ylab('Global_reactive_power') +
          scale_x_datetime(date_labels = '%a', date_breaks = '1 day') 

plot4 <- grid.arrange(plot2, plot4.1, plot3, plot4.2, ncol = 2)
ggsave(file='Plot4.png', width = 6.4, height = 6.4, unit = 'in', plot4)

