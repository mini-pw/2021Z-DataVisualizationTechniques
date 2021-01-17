source("read_html.R")
library(chron)
library(stringi)
library(tidyverse)

df <- data.frame(name = character(), date = character(), time = character(), 
           title = character(), parent = character(), semiidle = character(),
           keys = character(), lmb = character(), rmb = character(),
           scrollwheel = character())

for (file in dir("data")){
  for (inner_file in dir(file.path("data",file))){
    temp <- read_file(file, inner_file)
    df <- rbind(df, temp)
  }
}

df$date <- as.Date(df$date, format = "%d-%m-%Y")
df$keys <- as.numeric(df$keys)
df$rmb <- as.numeric(df$rmb)
df$lmb <- as.numeric(df$lmb)
df$scrollwheel <- as.numeric(df$scrollwheel)

df$time <- times(ifelse(stri_count_fixed(df$time, ":") == 2, df$time,
                  ifelse(stri_count_fixed(df$time, ":") == 1, 
                         stri_join("00:",df$time), stri_join("00:00:",df$time))))
write_csv2(df, "./visualization/data.csv")
