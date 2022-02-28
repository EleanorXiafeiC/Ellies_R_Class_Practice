##Optional challenge 2
##Repeat all problems in this assignment, but accomplish all the problems using the much higher-performance data analysis library, data.table. Quantify the performance improvement of data.table over dplyr.

library(data.table)

darfur_chairs = fread("time_series_data.csv")
darfur_chairs

##Find the maximum temperature value by household, and save this as a two-column dataframe named max_temperature_by_household with the columns: household_id and max_temperature 

max_temperature_by_household = darfur_chairs[,max(value), by = .(household_id)]
print(head(max_temperature_by_household))

##Temperatures above 130°C might damage the sensor. Find all the distinct camp, filename, and household_id combinations where temperature is above 130°C and name this three-column dataframe high_temperature_households

high_temperature_households = unique(darfur_chairs[value > 130, .(filename, camp, household_id)])
print(head(high_temperature_households))

##Filter all of darfur_data down to just the rows for household_ids in the high_temperature_households. Keep all the columns and rows of darfur_data just for those households. Hint: research and use the %in% operator to see if the high_temperature_households$household_id are in the  darfur_data$household_id column. Name this filtered 

hot_house_subset = 

