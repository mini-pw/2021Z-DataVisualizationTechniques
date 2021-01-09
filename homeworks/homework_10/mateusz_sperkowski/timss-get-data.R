library("readxl")
library(dplyr)
library(tidyr)

# Matematyka dla 4 klasy
M4 <- read_xlsx("1-1_achievement-results-M4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Total_avg" = "Average \r\nScale Score") %>%
  drop_na(Country)

M4G <- read_xlsx("1-5_achievement-gender-M4.xlsx", skip = 5) %>%
  select(3, 8, 14) %>%
  rename("Country" = "...3", "Girls_avg" = "Average\r\nScale Score...8", "Boys_avg" = "Average\r\nScale Score...14") %>%
  drop_na(Country)

M4G <- full_join(M4, M4G)
  
M4T<- read_xlsx("1-4_achievement-trends-M4.xlsx", skip = 5) %>%
  select(3, 5, 7, 9, 11, 13, 15) %>%
  drop_na(Country)

M4TG <- read_xlsx("1-6_achievement-gender-trends-M4.xlsx", skip = 5) %>%
  select(3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27) %>%
  rename("2019_G" = "2019", "2019_B" = "...7", "2015_G" = "2015", "2015_B" = "...11", 
         "2011_G" = "2011", "2011_B" = "...15", "2007_G" = "2007", "2007_B" = "...19",
         "2003_G" = "2003", "2003_B" = "...23", "1995_G" = "1995", "1995_B" = "...27") %>%
  drop_na(Country)
  
# Przyroda dla 4 klasy
S4 <- read_xlsx("2-1_achievement-results-S4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Total_avg" = "Average \r\nScale Score") %>%
  drop_na(Country)

S4G <- read_xlsx("2-5_achievement-gender-S4.xlsx", skip = 5) %>%
  select(3, 8, 14) %>%
  rename("Country" = "...3", "Girls_avg" = "Average\r\nScale Score...8", "Boys_avg" = "Average\r\nScale Score...14") %>%
  drop_na(Country)

S4G <- full_join(M4, M4G)

S4T<- read_xlsx("2-4_achievement-trends-S4.xlsx", skip = 5) %>%
  select(3, 5, 7, 9, 11, 13, 15) %>%
  drop_na(Country)

S4TG <- read_xlsx("2-6_achievement-gender-trends-S4.xlsx", skip = 5) %>%
  select(3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27) %>%
  rename("2019_G" = "2019", "2019_B" = "...7", "2015_G" = "2015", "2015_B" = "...11", 
         "2011_G" = "2011", "2011_B" = "...15", "2007_G" = "2007", "2007_B" = "...19",
         "2003_G" = "2003", "2003_B" = "...23", "1995_G" = "1995", "1995_B" = "...27") %>%
  drop_na(Country)

# Dla 8 klasy bedzie:
# 4-1_achievement-results-S8.xls

# Dobry punkt wyjścia dla poprzednich lat:
# https://en.wikipedia.org/wiki/Trends_in_International_Mathematics_and_Science_Study
# Uwaga, czasem wygodniej jest przepisać kilka liczb niż automatyzowaćich pobranie
rm(list = c("M4", "S4"))