library("readxl")
library(dplyr)
library(tidyr)
library(plotly)
library(ggplot2)
library(ggthemes)

M4<- read_xlsx("1-4_achievement-trends-M4.xlsx", skip = 5)%>%
  select(3, 5, 7, 9, 11, 13, 15)%>%
  drop_na(Country)
S4<- read_xlsx("2-4_achievement-trends-S4.xlsx", skip = 5)%>%
  select(3, 4, 6, 8, 10, 12, 14)%>%
  drop_na(Country)

M8<-read_xlsx("3-4_achievement-trends-M8.xlsx", skip = 5)%>%
  select(2, 4, 6, 8, 10, 12, 14,16)%>%
  drop_na(Country)

S8<-read_xlsx("4-4_achievement-trends-S8.xlsx", skip = 5)%>%
  select(2, 4, 6, 8, 10, 12, 14,16)%>%
  drop_na(Country)
