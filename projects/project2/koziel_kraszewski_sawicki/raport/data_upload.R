library(XML)
library(methods)
library(ggplot2)
library(dplyr)
library(tidyr)
library(rjson)
library(data.table)
library(readr)
library(maps)
library(RJSONIO)
library(sp)
library(maptools)

raw_data <- read_csv("waqi-covid-2020.csv", skip = 4) # omijamy pierwsze 4 wiersze, jakieś nagłówki
raw_data <- rbind(raw_data,read_csv("waqi-covid-2019Q1.csv", skip = 4),read_csv("waqi-covid-2019Q2.csv", skip = 4))


iso_codes<-read_csv("https://gist.githubusercontent.com/tadast/8827699/raw/f5cac3d42d16b78348610fc4ec301e9234f82821/countries_codes_and_coordinates.csv")

raw_data_2019 <- rbind(read_csv("waqi-covid-2019Q1.csv", skip = 4),
                       read_csv("waqi-covid-2019Q2.csv", skip = 4),
                       read_csv("waqi-covid-2019Q3.csv", skip = 4),
                       read_csv("waqi-covid-2019Q4.csv", skip = 4))

means_2019 <- raw_data_2019 %>%
  filter(Specie == "aqi") %>% 
  group_by(City) %>%
  summarize(mean_2019 = mean(median))

raw_data_2020 <- read_csv("waqi-covid-2020.csv", skip=4) 

covid_df <- read.csv("https://covid.ourworldindata.org/data/owid-covid-data.csv") %>% 
  mutate(Date = as.Date(date))