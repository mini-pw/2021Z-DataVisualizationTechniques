library("readxl")
library(dplyr)


# Matematyka dla 4 klasy
M4 <- read_xlsx("files/1-1_achievement-results-M4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("M4" = "Average \r\nScale Score") %>%
  na.omit()

# Matematyka dla 8 klas
M8 <- read_xlsx("files/3-1_achievement-results-M8.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("M8" = "Average \r\nScale Score") %>%
  na.omit()

# Przyroda dla 4 klasy
S4 <- read_xlsx("files/2-1_achievement-results-S4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("S4" = "Average \r\nScale Score") %>%
  na.omit()

# Przyroda dla 8 klasy
S8 <- read_xlsx("files/4-1_achievement-results-S8.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("S8" = "Average \r\nScale Score") %>%
  na.omit()

M4_instruction_type <- read_xlsx("files/12-2_instruction-time-M4.xlsx", skip = 3) %>%
  select(3, 6, 10) %>%
  rename("total_h" = "...6", "mat_h" = "...10") %>%
  mutate(mat_h = as.numeric(mat_h)) %>%
  na.omit()



# Dobry punkt wyjścia dla poprzednich lat:
# https://en.wikipedia.org/wiki/Trends_in_International_Mathematics_and_Science_Study
# Uwaga, czasem wygodniej jest przepisać kilka liczb niż automatyzowaćich pobranie.