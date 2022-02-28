

library(readxl)
library(tidyverse)
library(ggplot2)


parse_timeseries = function(ellie_excel_file) {
  lines_of_metadata = 23
  timeseries = read_xlsx(ellie_excel_file, skip = lines_of_metadata)
  return(timeseries)
}
timeseries = parse_timeseries("ellie_excel_file")
##cleaning things up

names(ellie_excel_file)

ellie_excel_file %>% select(-"...5")

##Read in the excel file and 
##parse the timeseries data into a variable called timeseries using your parser function
##Deselect the column named 'No.', rename the other columns, and redefine the result as a data frame named timeseries as shown at 


ellies_excel_to_timeseries_function = function(path_to_any_excel_file){
  a = read_xlsx(path_to_any_excel_file, skip = 23)
  return(a)
}

ellies_excel_to_timeseries_function = function(bottle){
  a = read_xlsx(bottle, skip = 23)
  return(a)
}

week6dataframe = ellies_excel_to_timeseries_function(bottle = "Week 6 data sheet.xlsx")
week7dataframe = ellies_excel_to_timeseries_function(bottle = "Week 7 data sheet.xlsx")



##Deselect the column named 'No.', rename the other columns, and redefine the result as a data frame named timeseries as shown at right

taco1 = taco %>% select(-'No.')
print(head(taco1))

# check the data types
typeof(taco1$time)
typeof(taco1$temperature)
typeof(taco1$humidity)

# change data types

##names in quotes

names(taco1)

timeseries = taco1 %>%
  rename(time = 'Time',
         temperature = 'Temperature???'
, humidity = 'Humidity%')

typeof(timeseries$time)
typeof(timeseries$temperature)
typeof(timeseries$humidity)

timeseries = timeseries %>% mutate(temperature = as.numeric(temperature))
timeseries = timeseries %>% mutate(humidity = as.numeric(humidity))
timeseries = timeseries %>% mutate(time = as.POSIXct(time))

ggplot(timeseries) +
  geom_bar(aes(x = time, y = humidity), color = 'blue') +
  geom_area(aes(x = time, y = temperature), color = 'red') +
  labs(title = 'temperature and humidity', y = 'value')

##Define a threshold at 24°C
##Make a new column, cooking, that says whether the temperature is above 24°C
##Plot temperature, and color it by cooking.

threshold = 24
timeseries = timeseries %>% mutate(cooking = temperature > threshold)

ggplot(timeseries) +
geom_point(aes(x = time, y = temperature, color = cooking))
labs(title = "temp and humidity")

threshold = function(cooking)
  a = if(temperature => 24)
    return("cooking")
else("not cooking")

threshold(timeseries) 

my_excel_file = "Week 6 data sheet.xlsx"