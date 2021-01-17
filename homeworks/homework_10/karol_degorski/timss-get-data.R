library("readxl")
library("dplyr")


# Matematyka dla 4 klasy
M4 <- read_xlsx("TIMSS-2019/1-1_achievement-results-M4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()
M4 <- M4[c(1:59),]
M4 <- M4 %>% filter(!Country%in%c("TIMSS Scale Centerpoint"))
M42019 <- M4[c(1:10),]

M4UE <- M4 %>% filter(Country %in% c("Austria", "Belgium (Flemish)", "Bulgaria", "Croatia", "Cyprus",
                                     "Czech Republic", "Denmark", "Estonia", "Finland", "France", "Germany",
                                     "Greece", "Hungary", "Ireland", "Italy", "Latvia", "Lithuania", "Luxembourg",
                                     "Malta", "Netherlands", "Poland", "Portugal", "Romania", "Slovak Republic", "Slovenia",
                                     "Spain", "Sweden"))

# Matematyka dla 8 klasy
M8 <- read_xlsx("TIMSS-2019/3-1_achievement-results-M8.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()
M8 <- M8[c(1:40),]
M8 <- M8 %>% filter(!Country%in%c("TIMSS Scale Centerpoint"))
M82019 <- M8[c(1:11),]


M8UE <- M8 %>% filter(Country %in% c("Austria", "Belgium (Flemish)", "Bulgaria", "Croatia", "Cyprus",
                                     "Czech Republic", "Denmark", "Estonia", "Finland", "France", "Germany",
                                     "Greece", "Hungary", "Ireland", "Italy", "Latvia", "Lithuania", "Luxembourg",
                                     "Malta", "Netherlands", "Poland", "Portugal", "Romania", "Slovak Republic", "Slovenia",
                                     "Spain", "Sweden"))

# Przyroda dla 4 klasy
S4 <- read_xlsx("TIMSS-2019/2-1_achievement-results-S4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()
S4 <- S4[c(1:59),]
S4 <- S4 %>% filter(!Country%in%c("TIMSS Scale Centerpoint"))
S42019 <- S4[c(1:10),]

S4UE <- S4 %>% filter(Country %in% c("Austria", "Belgium (Flemish)", "Bulgaria", "Croatia", "Cyprus",
                                     "Czech Republic", "Denmark", "Estonia", "Finland", "France", "Germany",
                                     "Greece", "Hungary", "Ireland", "Italy", "Latvia", "Lithuania", "Luxembourg",
                                     "Malta", "Netherlands", "Poland", "Portugal", "Romania", "Slovak Republic", "Slovenia",
                                     "Spain", "Sweden"))

# Przyroda dla 8 klasy
S8 <- read_xlsx("TIMSS-2019/4-1_achievement-results-S8.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()
S8 <- S8[c(1:40),]
S8 <- S8 %>% filter(!Country%in%c("TIMSS Scale Centerpoint"))
S82019 <- S8[c(1:10),]

S8UE <- S8 %>% filter(Country %in% c("Austria", "Belgium (Flemish)", "Bulgaria", "Croatia", "Cyprus",
                                     "Czech Republic", "Denmark", "Estonia", "Finland", "France", "Germany",
                                     "Greece", "Hungary", "Ireland", "Italy", "Latvia", "Lithuania", "Luxembourg",
                                     "Malta", "Netherlands", "Poland", "Portugal", "Romania", "Slovak Republic", "Slovenia",
                                     "Spain", "Sweden"))

# Matematyka dla 4 klasy z podziałem na płeć
M4plec <- read_xlsx("TIMSS-2019/1-5_achievement-gender-M4.xlsx", skip = 5) %>%
  select(3, 8, 14) %>%
  na.omit()
colnames(M4plec) <- c("Country", "Girls", "Boys")
M4plec <- M4plec %>% filter(!Country == "International Average")
M4plec <- M4plec[c(1:58),]

# Matematyka dla 8 klasy z podziałem na płeć
M8plec <- read_xlsx("TIMSS-2019/3-5_achievement-gender-M8.xlsx", skip = 5) %>%
  select(3, 8, 14) %>%
  na.omit()
colnames(M8plec) <- c("Country", "Girls", "Boys")
M8plec <- M8plec %>% filter(!Country == "International Average")
M8plec <- M8plec[c(1:39),]

# Przyroda dla 4 klasy z podziałem na płeć
S4plec <- read_xlsx("TIMSS-2019/2-5_achievement-gender-S4.xlsx", skip = 5) %>%
  select(3, 8, 14) %>%
  na.omit()
colnames(S4plec) <- c("Country", "Girls", "Boys")
S4plec <- S4plec %>% filter(!Country == "International Average")
S4plec <- S4plec[c(1:58),]

# Przyroda dla 8 klasy z podziałem na płeć
S8plec <- read_xlsx("TIMSS-2019/4-5_achievement-gender-S8.xlsx", skip = 5) %>%
  select(3, 8, 14) %>%
  na.omit()
colnames(S8plec) <- c("Country", "Girls", "Boys")
S8plec <- S8plec %>% filter(!Country == "International Average")
S8plec <- S8plec[c(1:39),]


# Dobry punkt wyjścia dla poprzednich lat:
# https://en.wikipedia.org/wiki/Trends_in_International_Mathematics_and_Science_Study
# Uwaga, czasem wygodniej jest przepisać kilka liczb niż automatyzowaćich pobranie.