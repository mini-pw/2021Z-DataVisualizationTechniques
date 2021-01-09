library("readxl")
library(dplyr)

##----------------------Średni wynik----------------------

# Matematyka dla 4 klasy
M4 <- read_xlsx("dane/1-1_achievement-results-M4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()
# Matematyka dla 8 klasy
M8 <- read_xlsx("dane/3-1_achievement-results-M8.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()

# Przyroda dla 4 klasy
S4 <- read_xlsx("dane/2-1_achievement-results-S4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()
# Przyroda dla 8 klasy
S8 <- read_xlsx("dane/4-1_achievement-results-S8.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()


##----------------------Dyscyplina----------------------

disM4 <- read_xlsx("dane/8-2_school-discipline-M4.xlsx", skip = 5) %>%
   select(3,6,9,12,15,18,21) %>% 
   rename("Country"="...3", 
          "percentAny"="Percent of Students...6" ,
          "averageAny"="Average Achievement...9",
          "percentMinor"="Percent of Students...12",
          "averageMinor"="Average Achievement...15",
          "percentBig" = "Percent of Students...18",
          "averageBig" = "Average Achievement...21") #%>% 
  # na.omit()

disM8 <- read_xlsx("dane/8-4_school-discipline-M8.xlsx", skip = 5) %>%
  select(3,6,9,12,15,18,21) %>% 
  rename("Country"="...3", 
         "percentAny"="Percent of Students...6" ,
         "averageAny"="Average Achievement...9",
         "percentMinor"="Percent of Students...12",
         "averageMinor"="Average Achievement...15",
         "percentBig" = "Percent of Students...18",
         "averageBig" = "Average Achievement...21") %>% 
  na.omit()

disS4 <- read_xlsx("dane/8-3_school-discipline-S4.xlsx", skip = 5) %>%
  select(3,6,9,12,15,18,21) %>% 
  rename("Country"="...3", 
         "percentAny"="Percent of Students...6" ,
         "averageAny"="Average Achievement...9",
         "percentMinor"="Percent of Students...12",
         "averageMinor"="Average Achievement...15",
         "percentBig" = "Percent of Students...18",
         "averageBig" = "Average Achievement...21") %>% 
  na.omit()

disS8 <- read_xlsx("dane/8-5_school-discipline-S8.xlsx", skip = 5) %>%
  select(3,6,9,12,15,18,21) %>% 
  rename("Country"="...3", 
         "percentAny"="Percent of Students...6" ,
         "averageAny"="Average Achievement...9",
         "percentMinor"="Percent of Students...12",
         "averageMinor"="Average Achievement...15",
         "percentBig" = "Percent of Students...18",
         "averageBig" = "Average Achievement...21") %>% 
  na.omit()