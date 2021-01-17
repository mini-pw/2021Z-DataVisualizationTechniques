library(readxl)
library(dplyr)

## Przygotowanie danych przetwarzania 

# Wczytywanie danych o matematyce

math_4th <- read_xlsx("./dane/1-1_achievement-results-M4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  na.omit()
colnames(math_4th) <- c("Country", "four")

math_8th <- read_xlsx("./dane/3-1_achievement-results-M8.xlsx", skip = 4) %>%
  select(3, 5) %>% na.omit()
colnames(math_8th) <- c("Country", "eight")
 
math <- full_join(math_4th, math_8th, by = "Country")
 
# Wczytywanie danych o naukach przyrodniczych 

science_4th <- read_xlsx("./dane/2-1_achievement-results-S4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  na.omit()
colnames(science_4th) <- c("Country", "four")
 
science_8th <- read_xlsx("./dane/4-1_achievement-results-S8.xlsx", skip = 4) %>%
  select(3, 5) %>%
  na.omit()
colnames(science_8th) <- c("Country", "eight")
 
science <- full_join(science_4th, science_8th, by = "Country")

welth <- read_xlsx("./dane/6-2_school-composition-ses-M4.xlsx", skip = 4) %>%
  select(3, 6) %>%
  na.omit()
colnames(welth) <- c("Country", "Affluent")

math <- full_join(math, welth, by = "Country")
science <- full_join(science, welth, by = "Country")

write.csv(math, "./dane/math.csv", row.names = FALSE)
write.csv(science, "./dane/science.csv", row.names = FALSE)

