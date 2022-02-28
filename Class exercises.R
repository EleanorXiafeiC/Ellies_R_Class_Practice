darfur_data <- read.csv("time_series_data.csv")
darfur_data

head(darfur_data)
str(darfur_data)

darfur_data$filename

camp_value <- darfur_data[, c("camp", "value")]
dim(camp_value)
head(camp_value)

names(darfur_data)
darfur_data_neg <- darfur_data[, -c(3, 4, 5)]
dim(darfur_data_neg)
head(darfur_data_neg)

install.packages("tidyverse")
library(tidyr)
library(dplyr)

#darfur_data %>% group_by_camp
darfur_data%>% distinct(camp)

darfur_data %>% select(datalogger_id)
darfur_data %>% select(unit)

darfur_data %>% select(value)

darfur_data$time 
darfur_data$value

min(darfur_data$value)
max(darfur_data$value)

darfur_data(household_id, filename)%>%
  summarise(min_temperature = min(value)