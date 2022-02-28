library(readxl)

parse_metadata = function(excelfile){
  my_file = read_xlsx(excelfile)
serial_number = my_file[[5, 2]]
 device_model = my_file[[4, 2]]
 probe_type = my_file[[4, 5]]
 firmware_version = my_file[[5, 5]]
 trip_number = my_file[[7, 2]]
 trip_description = my_file[[8, 2]]
 start_mode = my_file[[10, 2]]
 start_delay = my_file[[11, 2]]
 time_zone = my_file[[12, 2]]
 logging_interval = my_file[[10, 5]]
 repeat_start = my_file[[11, 5]]
 stop_mode = my_file[[12, 5]]
 output = data.frame(serial_number, device_model, probe_type, firmware_version, trip_number, trip_description,
                     start_mode, start_delay, time_zone, logging_interval, repeat_start, stop_mode)
 return(output)
}
metadata = parse_metadata("HM1210201800_0000002.xlsx")

parse_timeseries = function(excelfile){
  my_file = read_xlsx(excelfile, skip = 23)
  output = data.frame(my_file)
  return(output)
}
timeseries = parse_timeseries("HM1210201800_0000002.xlsx")

merged_data = merge(timeseries, metadata)
merged_data

print(head(metadata))

print(head(timeseries))

print(head(merged_data))

#challenge 1

#Cast Time as a POSIXct timestamp, floor timestamp to the nearest hour (try the lubricate package) and call that column hour, 

#rename `Humidity%` to humidity,

#and then find the maximum humidity by hour (2-column data frame). Name this dataframe max_humidity_by_hour.

print(merged_data$Humidity.)

#humidity values saved as characters 
#character to a float


#time is read in as a string
#not helpful for plotting
#flooring = everything that happens within 1 hr
#celing
#taste-ing??


library(lubridate)
merged_data[[1,2]]

time_stamp = parse_date_time(merged_data$Time, "YMD HMS")

hour = floor_date(time_stamp, unit = "hours")
hour
  
library(dplyr)

merged_data$hour = hour

hour %>% merged_data

names(merged_data)[4] = c("humidity")

merged_data$humidity %>% merged_data 

temperaturehrs =  data.frame(merged_data$humidity, merged_data$hour)
temperaturehrs

library(dplyr)

names(temperaturehrs)[1] = c("humidity")
names(temperaturehrs)[2] = c("hour")

temperaturehrs$humidity %>% temperaturehrs
temperaturehrs$hour %>% temperaturehrs

max_humidity_by_hour = temperaturehrs %>% group_by(hour) %>% summarize(humidity = max(humidity))
print(head(max_humidity_by_hour))

                                                                                                

##what is the question asking: 
#for every hour long mark, there is a maximum temperature
## i want to find two things
##the max temp and per hour
##what's on the x: hr
##what's on the y: temp
## filter distinct: hr



