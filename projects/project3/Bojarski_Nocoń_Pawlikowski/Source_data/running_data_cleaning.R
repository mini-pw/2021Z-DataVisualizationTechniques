library(parsedate)

# set working directory as the same as this file
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# read data from file
raw_data <- read.table("running_data_raw.csv", header = TRUE, sep = ",")

# get only "run" activity
running_data <- raw_data[raw_data$Activity.Type == "Run", ]

# get rid of unuseful columns
running_data <- running_data[, c(2, 5, 6)]

# convert second to hours
running_data$Workout.Time..seconds. <- running_data$Workout.Time..seconds./3600

# change column names to be more user frendly
colnames(running_data) <- c("date", "distance_km", "time_h")

# delete data which contain error (time = 0 or distance = 0)
running_data <- running_data[running_data$distance_km != 0 & 
                               running_data$time_h != 0, ]

# change date to more friendly format
running_data$date <- parse_date(running_data$date)

# save data
write.table(running_data, file = "running_data.txt", sep = "\t", 
            quote = FALSE, row.names = FALSE)
