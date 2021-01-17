library(dplyr)
library(jsonlite)
library(hms)

#-------------------------------STEPS READING-------------------------------
read_file_csv <- function(file_path) {
  df <- read.csv(file_path, skip=1, row.names = NULL) %>% 
    select(1,6,11,12) 
  
  rownames(df) <- NULL
  colnames(df) <- c("step_count","update_time","distance","calorie")
  
  df$update_time <- format(as.Date(df$update_time,origin = "1970-01-01"), "%Y-%m-%d")
  
  df <- df %>% 
    unique() %>%
    filter(update_time > as.Date('2020-12-19')) %>% 
    arrange(step_count)
  
  df <- df[!duplicated(df[,'update_time']),] %>% 
    arrange(update_time)
  
  return(df)
}

read_file_csv_forKarol <- function(file_path) {
  df <- read.csv(file_path, skip=1, row.names = NULL) %>% 
    select(1,3,6,7,12,12) 
  
  colnames(df) <- c("speed","step_count","start_time","calorie","distance")
  
  df$start_time <- format(as.Date(df$start_time,
                                   "%d.%m.%Y",
                                   origin = "1970-01-01,"), "%Y-%m-%d") 
  df <- df %>% 
    group_by(start_time) %>% 
    summarise(calorie = sum(calorie), step_count = sum(step_count), distance = sum(distance)) %>% 
    filter(start_time > as.Date('2020-12-19')) %>% 
    rename(update_time = start_time)
  
  return(df)
}

#-------------------------------SLEEP READING-------------------------------

read_file_json <- function(file_path) {
  data <- fromJSON(file_path)
  
  data$start <- as.POSIXlt(data$start, format = "%Y-%m-%dT%H:%M:%OS")
  data$stop <- as.POSIXlt(data$stop, format = "%Y-%m-%dT%H:%M:%OS")
  
  df <- data.frame(asleep = as_hms(data$stop-data$start),
                   day = nrow(data):1)
  
  return(df)
}
