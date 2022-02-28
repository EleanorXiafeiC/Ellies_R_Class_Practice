install.packages(tibble)
library(readxl)
library(tidyverse)
library(dplyr)
library(ggplot2)


##Download then unzip and read class_data.csv (Links to an external site.) and save it as a data frame named class_data. You can unzip the CSV file using R or any other tool on your computer. 

class_data = read.csv("class_data.csv")
print(head(class_data))

##Cast time as a posixct.

class_data = class_data %>% mutate(time = as.POSIXct(time))

##Create a new column called “temp_diff” that is the rate change of temperature in °C/minute of adjacent samples. Make sure this is grouped by person and is padded with an NA for the first sample.

class_data = class_data %>% group_by(person) %>% mutate(temp_diff = c(NA, diff(temperature)))

class_data = class_data %>% mutate(temperature = as.numeric(temperature))
class_data %>% group_by(person)

temp_diff_funct = function(temperature, time)
  temperature = class_data$temperature
  time = class_data$time
a = (temperature/time)
return(a)

class_data$temp_diff = temp_diff_funct(temperature, time)

time_stamp = parse_date_time(merged_data$Time, "YMD HMS")

hour = floor_date(time_stamp, unit = "hours")
hour

merged_data$hour = hour

hour %>% merged_data

##Make a plot of your temperature data from your logger vs. time. 
##If your temperature data is not available in the dataset, use a friend (or Danny’s) data. Hint: filter(person == 'danny_wilson') is the syntax for saying “where person IS danny_wilson.” Write some comments in your script about the content and quality of the temperature data. What kind of activities and phenomena do you see? How well did the cooking event detection algorithm work?

parse_timeseries = function(excelfile){
  my_file = read_xlsx(excelfile, skip = 26)
  output = data.frame(my_file)
  return(output)
}


datalogger_function = function(csv_file, spreadsheet){
  meta_data = parse_metadata(csv_file)
  timeseries = parse_timeseries(csv_file)
  merged_data = merge(timeseries, meta_data)
  write.csv(merged_data, spreadsheet)
  
  return(merged_data)
}

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



ellie_chin = datalogger_function("Feb 13 data log.xlsx","ellie_chin.csv")
print(head(ellie_chin))

class_data = class_data %>% mutate(cooking_better = temperature > 20 & temperature <24 & humidity >20 & humidity <50)
print(head(class_data))

ellie_chin_class_data = class_data %>% filter(person == "ellie_chin")

typeof(ellie_chin_class_data)

ggplot(ellie_chin_class_data)
geom_line(aes(x = time, y = temperature))+
  labs(x = "time", y = "temperature")
  
##summarize the cooking data 
ellie_chin_class_data = ellie_chin_class_data %>% mutate(cooking = temperature > 20 & temperature <24 & humidity >20 & humidity <50)
  print(head(ellie_chin_class_data))
  
ellie_chin_class_data %>% summarize(
total_minutes = n(),
cooking_minutes = sum(cooking, na.rm = TRUE),
percent_time_cooking = sum(cooking, na.rm = TRUE) / n() * 100)
print(head(ellie_chin_class_data))

ellie_chin_class_data %>% mutate(time = as.POSIXct(time))
ellie_chin_class_data %>% mutate(temperature = as.numeric(temperature))

ggplot(ellie_chin_class_data)
geom_line(aes(x = time, y = temperature))+
  labs(x = "time", y = "temperature")


#/Make a plot of 5 random students’ temperature data and facet it by person. Write some comments in your script about the content and quality of the temperature data. What kind of activities and phenomena do you see? How well did the cooking event detection algorithm work?

friends_data = class_data %>% filter(brian_hohl, abigail_chin)
ggplot(friends_data)
geom_line(x = time, y = temperature)
