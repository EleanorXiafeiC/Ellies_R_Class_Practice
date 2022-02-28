
library(readxl)
library(tidyverse)
library(ggplot2)
library(dplyr)

#/Required problem 0: Using the parsing functions you wrote last week, parse your own data logger data into a data frame that is in the merged format at the end of the Week 4 assignment.This data frame should be 16 columns and about 20k rows (1 sample/minute * 14 days). Using the write.csv() function, write this merged data frame out to a CSV file named{first_name}_{last_name}.csv (for example danny_wilson.csv).

parse_timeseries = function(excelfile){
  my_file = read_xlsx(excelfile, skip = 26)
  output = data.frame(my_file)
  return(output)
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

datalogger_function = function(csv_file, spreadsheet){
   meta_data = parse_metadata(csv_file)
   timeseries = parse_timeseries(csv_file)
   merged_data = merge(timeseries, meta_data)
   write.csv(merged_data, spreadsheet)
   
  return(merged_data)
}

ellie_chin = datalogger_function("Feb 13 data log.xlsx","ellie_chin.csv")
print(head(ellie_chin))


#/Required Problem 1: Parse the datalogger into a variable called timeseries. Drop the first column named 'No.' and simplify the names of the other columns to: time, temperature, and humidity.

timeseries_run = function(excel_sheet){
  a = read_xlsx(excel_sheet, skip = 23)
  return(a)
}

timeseries = timeseries_run("Week 6 data sheet.xlsx")
timeseries = timeseries %>% select(-"No.")

names(timeseries)


timeseries = timeseries %>%
  rename(time = 'Time',
         temperature = 'Temperature℃'
         , humidity = 'Humidity%')

#required problem 2: 
##Make an area chart (geom_area) of temperature with the title "Temperature vs. time," the y axis name "temperature (?C)" and the x axis name "time."

timeseries = timeseries %>% mutate(temperature = as.numeric(temperature))
timeseries = timeseries %>% mutate(time = as.POSIXct(time))
timeseries = timeseries %>% mutate(humidity = as.numeric(humidity))


ggplot(timeseries) +
  geom_area(aes(x = time, y = temperature)) + 
  labs(title = "temperature vs. time", x = "time", y = "temperature degrees centigrade")


#Required problem 3: Make a plot with two line plots: temperature and humidity. The temperature trace should be red, the humidity trace should be blue. The title should be "Temperature and humidity vs. time," the y axis should be named "value" and the x axis should be named "time."

ggplot(timeseries) + 
  geom_line(aes(x = time, y = humidity, color = "red"))+
  geom_line(aes(x=time,y=temperature, color = "blue")) +
    labs(x = 'time', y = 'value', title = "Temperature and Humidity vs. time")


#/Required problem 4: Define a threshold temperature of 24?C and then mutate your timeseries dataframe to include a new boolean called "cooking" that is true if the temperature is above the threshold.

threshold = 24 
timeseries = timeseries %>% mutate(cooking = temperature >= threshold)
print(head(timeseries))

sum(timeseries$cooking)


#/Required Problem 5: Create a scatter plot of temperature vs. time and color the plot by the cooking status. Also, make the shape of the scatter point dependent on cooking status. Label the axes and title of the plot completely and appropriately using the pattern of nomenclature you have practiced so far.

ggplot(timeseries) + 
  geom_point(aes(x=time,y=temperature, shape = cooking, color = cooking)) +
   labs(x = 'time', y = 'temperature', title = "Temperature and Time")

#/Required Problem 6: Add to the plot in problem 5 a line plot of humidity for reference. The humidity trace should be a black line on top of the scatter of temperatures. 

ggplot(timeseries) + 
  geom_point(aes(x=time,y=temperature, shape = cooking, color = cooking)) +
  geom_line(aes(x = time, y = humidity))+
  labs(x = 'time', y = 'temperature', title = "Temperature and Time")

#/Required Problem 7: Filter the source data only to times between '2022-02-09 03:00' and '2022-02-09 09:00.' Replot the data from problem 5, but only for this time range. 

timeseries = timeseries %>% filter(time < '2022-02-09 09:00') %>% 
  filter(time > '2022-02-09 03:00')

ggplot(timeseries %>% filter(time < '2022-02-09 09:00') %>% 
         filter(time > '2022-02-09 03:00'))+
  geom_point(aes(x = time, y = temperature, color = cooking))

print(names(timeseries))
print(head(timeseries))


#/Question 8 Look at the result of the cooking algorithm plotted in problem 7. Does it look right to you? What is it doing wrong? What could be improved? What clues do the temperature and humidity traces tell you about the start and stop of cooking events? Write a narrative description of how an improved cooking event detection algorithm would work? What would you do to detect cooking from start to stop more accurately? 

#/I think it looks a bit weird with the huge dip in humidity over the giant spike in temperature.  That seems a bit odd to me. I don't know what it might be doing wrong.  How would I improve it? I might set another threshold for the humidity value to more closely match with the cooking value. I would also figure out a way to detect peak heat and then anything less than that would be marked "non-cooking." Some friends told me to try to use the Delta of temp but I wouldn't know how to express that mathematically in a way the computer could read. Also I don't trust that I have any intuition on how a cooking graph should look. Instead of temperature and humidity on an electric stove, I might try to find a way to measure when the electricity is turned on and off.  I suppose this method makes more sense for a gas stove though.

#/Challenge question: 
#/Implement your improved cooking detection algorithm, save it's output as a new column called cooking_better, and replot the  '2022-02-09 03:00' and '2022-02-09 09:00' time range to show off your improved analytics. 

threshold_humidity_min = 20
threshold_humidity_max = 50
threshold_cooking_high = 24
threshold_cooking_low = 20

timerange = timeseries %>% filter(time < '2022-02-09 09:00') %>% 
  filter(time > '2022-02-09 03:00')

timeseries = timeseries %>% mutate(cooking_better = temperature > 20 & temperature <24 & humidity >20 & humidity <50)
print(head(timeseries))

ggplot(timeseries %>% filter(time < '2022-02-09 09:00') %>% 
         filter(time > '2022-02-09 03:00'))+
  geom_point(aes(x = time, y = temperature, color = cooking_better))+
  labs(title = "time and temperature cooking better", x = "time", y = "temperature")
