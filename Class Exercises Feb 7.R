directory = ("Class Exercises Feb 7/")
directory

install.packages('readxl')

library(readxl)

read_xlsx("Class Exercises Feb 7/HM1210201800_0000002.xlsx")

all_excel_data = read_xlsx("Class Exercises Feb 7/HM1210201800_0000002.xlsx")
all_excel_data

excel_timeseries = read_xlsx("Class Exercises Feb 7/HM1210201800_0000002.xlsx", skip = 23)
print(head(excel_timeseries))

excel_metadata = read_xlsx('Class Exercises Feb 7/HM1210201800_0000002.xlsx', n_max = 23)
print(head(excel_metadata))

##excel_metadata1 = read_xlsx("Class Exercises Feb 7/HM1210201800_0000002.xlsx", n_min = 100)
##print(head(excel_metadata1))

serial_number = excel_metadata[[5, 2]]
serial_number
##think of this like an ordered pair 

device_model = excel_metadata[[4, 2]]
device_model

probe_type = excel_metadata[[4, 5]]
probe_type 

meta_time = merge(excel_metadata, excel_timeseries)
print(head(meta_time))

testmetadata = data.frame(serial_number, device_model)
testmetadata

##serial_number 
##device_model 
##probe_type
#firmware_version
#trip_number
#trip_description 
#start_mode 
#start_delay
#time_zone
#logging_interval 
#repeat_start
#stop_mode

