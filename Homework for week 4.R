library(tidyverse)

darfur_data = read.csv("203 HW/Challenge HW Week 3/time_series_data.csv")
darfur_data
print(head(darfur_data))

max_temperature_by_household <- darfur_data %>% group_by(household_id) %>% summarize(max_temperature = max(value))
print(head(max_temperature_by_household))

high_temperature_households <- darfur_data%>% filter(value >130 )%>% distinct(filename, camp, household_id)
print(head(high_temperature_households))

sum(darfur_data$household_id %in% high_temperature_households$household_id)
darfur_data_hot_house_subset = darfur_data %>% filter(darfur_data$household_id %in% 
                                                 high_temperature_households$household_id)
print(head(darfur_data_hot_house_subset))

low_temp_houses <- max_temperature_by_household %>% filter(max_temperature <= 130 )
low_temp_houses

sum(darfur_data$household_id %in% low_temp_houses$household_id)
darfur_data_cold_houses = darfur_data %>% filter(darfur_data$household_id %in% 
                                                   low_temp_houses$household_id)
print(head(darfur_data_cold_houses))

print(head(darfur_data))
print(head(max_temperature_by_household))
print(head(high_temperature_households))
print(head(darfur_data_hot_house_subset))
print(head(low_temp_houses))

