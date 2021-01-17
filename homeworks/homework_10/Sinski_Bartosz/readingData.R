library(readxl)
library(dplyr)
library(reshape2)

# Matematyka dla 4 klasy
M4t <- read_xlsx("1-3_achievement-trends-M4.xlsx", skip = 5) %>% select(-starts_with(".")) %>% filter(!is.na(Country)) %>% 
  melt(id.vars="Country",variable.name = "year")
M4t[is.na(M4t)] <- 0 

# Matematyka dla 8 klasy
M8t <- read_xlsx("3-3_achievement-trends-M8.xlsx", skip = 5) %>% select(-starts_with(".")) %>% filter(!is.na(Country)) %>% 
  melt(id.vars="Country",variable.name = "year")
M8t[is.na(M8t)] <- 0 

Mt <- left_join(M4t,M8t,by=c("Country","year")) %>% rename(value4 = value.x, value8 = value.y)
Mt[is.na(Mt)] <- 0 
Mt <- melt(Mt,id.vars=c("Country","year"),variable.name = "grade") 

# Przyroda dla 4 klasy
S4t <- read_xlsx("2-3_achievement-trends-S4.xlsx", skip = 5) %>% select(-starts_with(".")) %>% filter(!is.na(Country)) %>% 
  melt(id.vars="Country",variable.name = "year")
S4t[is.na(S4t)] <- 0 

# Przyroda dla 8 klasy
S8t <- read_xlsx("4-3_achievement-trends-S8.xlsx", skip = 5) %>% select(-starts_with(".")) %>% filter(!is.na(Country)) %>% 
  melt(id.vars="Country",variable.name = "year")
S8t[is.na(S8t)] <- 0 

St <- left_join(S4t,S8t,by=c("Country","year")) %>% rename(value4 = value.x, value8 = value.y)
St[is.na(St)] <- 0 
St <- melt(St,id.vars=c("Country","year"),variable.name = "grade")
