library("readxl")
library(dplyr)


# Matematyka dla 4 klasy
M4 <- read_xlsx("./homeworks/homework_10/files/TIMSS-2019/1-1_achievement-results-M4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()

# Dla 8 klasy bedzie:
# 3-1_achievement-results-M8.xlsx

# Przyroda dla 4 klasy
S4 <- read_xlsx("./homeworks/homework_10/files/TIMSS-2019/2-1_achievement-results-S4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()

# Dla 8 klasy bedzie:
# 4-1_achievement-results-S8.xls


# Dobry punkt wyjścia dla poprzednich lat:
# https://en.wikipedia.org/wiki/Trends_in_International_Mathematics_and_Science_Study
# Uwaga, czasem wygodniej jest przepisać kilka liczb niż automatyzowaćich pobranie.