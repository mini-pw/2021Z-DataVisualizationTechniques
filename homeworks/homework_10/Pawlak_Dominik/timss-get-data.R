library("readxl")
library(dplyr)


# Matematyka dla 4 klasy
M4 <- read_xlsx("./ChosenData/M4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  na.omit() %>%
  setNames(., c("Country", "Score"))

# z podzialem na plec
M4G <- read_xlsx("./ChosenData/M4G.xlsx", skip = 6) %>%
  select(3, 5, 7) %>%
  na.omit() %>%
  setNames(., c("Country", "Girls", "Boys"))

# Przyroda dla 4 klasy
S4 <- read_xlsx("./ChosenData/S4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  na.omit() %>%
  setNames(., c("Country", "Score"))

# z podzialem na plec
S4G <- read_xlsx("./ChosenData/S4G.xlsx", skip = 6) %>%
  select(3, 5, 7) %>%
  na.omit() %>%
  setNames(., c("Country", "Girls", "Boys"))

# Matematyka dla 8 klasy
M8 <- read_xlsx("./ChosenData/M8.xlsx", skip = 4) %>%
  select(3, 5) %>%
  na.omit() %>%
  setNames(., c("Country", "Score"))

# z podzialem na plec
M8G <- read_xlsx("./ChosenData/M8G.xlsx") %>%
  select(3, 5, 7) %>%
  na.omit() %>%
  setNames(., c("Country", "Girls", "Boys"))

# Przyroda dla 8 klasy
S8 <- read_xlsx("./ChosenData/S8.xlsx", skip = 4) %>%
  select(3, 5) %>%
  na.omit() %>%
  setNames(., c("Country", "Score"))

# z podzialem na plec
S8G <- read_xlsx("./ChosenData/S8G.xlsx") %>%
  select(3, 5, 7) %>%
  na.omit() %>%
  setNames(., c("Country", "Girls", "Boys"))

M_4 <- inner_join(M4, M4G, by = "Country")
S_4 <- inner_join(S4, S4G, by = "Country")
M_8 <- inner_join(M8, M8G, by = "Country")
S_8 <- inner_join(S8, S8G, by = "Country")
rm(M4, M4G, S4, S4G, M8, M8G, S8, S8G)

# Dane badajace procent uczniow lubiacych przedmiot 
M4L <- read_xlsx("./ChosenData/M4L.xlsx", skip = 5) %>%
  select(3, 6, 12, 18) %>%
  na.omit() %>%
  setNames(., c("Country", "Like Very Much", "Somewhat Like", "Do Not Like"))

S4L <- read_xlsx("./ChosenData/S4L.xlsx", skip = 5) %>%
  select(3, 6, 12, 18) %>%
  na.omit() %>%
  setNames(., c("Country", "Like Very Much", "Somewhat Like", "Do Not Like"))

M8L <- read_xlsx("./ChosenData/M8L.xlsx", skip = 5) %>%
  select(3, 6, 12, 18) %>%
  na.omit() %>%
  setNames(., c("Country", "Like Very Much", "Somewhat Like", "Do Not Like"))
M4L <- arrange(M4L, Country)

S8L <- read_xlsx("./ChosenData/S8L.xlsx", skip = 5, n_max = 45) %>%
  select(3, 6, 12, 18) %>%
  na.omit() %>%
  setNames(., c("Country", "Like Very Much", "Somewhat Like", "Do Not Like"))
