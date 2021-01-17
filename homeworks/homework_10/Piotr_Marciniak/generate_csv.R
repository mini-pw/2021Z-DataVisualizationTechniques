library(readxl)
library(dplyr)
library(tidyr)
library(readr)

setwd("./homeworks/homework_10/Piotr_Marciniak/data")
setwd("./homeworks/homework_10/Piotr_Marciniak/")
setwd("./data")
setwd("..")
getwd()

M4 <- read_xlsx("1-1_achievement-results-M4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit() %>%
  mutate(Subject = "Math") %>%
  mutate(Gender = "Both") %>%
  mutate(Class = 4)
S4 <- read_xlsx("2-1_achievement-results-S4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit() %>%
  mutate(Subject = "Science") %>%
  mutate(Gender = "Both") %>%
  mutate(Class = 4)

M8 <- read_xlsx("3-1_achievement-results-M8.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit() %>%
  mutate(Subject = "Math") %>%
  mutate(Gender = "Both") %>%
  mutate(Class = 8)

S8 <- read_xlsx("2-1_achievement-results-S4.xlsx", skip = 4) %>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit() %>%
  mutate(Subject = "Science") %>%
  mutate(Gender = "Both") %>%
  mutate(Class = 8)

GM4 <- read_xlsx("1-5_achievement-gender-M4.xlsx", skip = 4) %>%
  select(3, 8, 14) %>%
  rename(Girls = ...8) %>%
  rename(Boys = ...14) %>%
  na.omit() %>%
  pivot_longer(!Country, names_to = "Gender", values_to = "Score") %>%
  mutate(Subject = "Math") %>%
  mutate(Class = 4)

GS4 <- read_xlsx("2-5_achievement-gender-S4.xlsx", skip = 4) %>%
  select(3, 8, 14) %>%
  rename(Girls = ...8) %>%
  rename(Boys = ...14) %>%
  na.omit() %>%
  pivot_longer(!Country, names_to = "Gender", values_to = "Score") %>%
  mutate(Subject = "Science") %>%
  mutate(Class = 4)

GM8 <- read_xlsx("3-5_achievement-gender-M8.xlsx", skip = 4) %>%
  select(3, 8, 14) %>%
  rename(Girls = ...8) %>%
  rename(Boys = ...14) %>%
  na.omit() %>%
  pivot_longer(!Country, names_to = "Gender", values_to = "Score") %>%
  mutate(Subject = "Math") %>%
  mutate(Class = 8)

GS8 <- read_xlsx("4-5_achievement-gender-S8.xlsx", skip = 4) %>%
  select(3, 8, 14) %>%
  rename(Girls = ...8) %>%
  rename(Boys = ...14) %>%
  na.omit() %>%
  pivot_longer(!Country, names_to = "Gender", values_to = "Score") %>%
  mutate(Subject = "Science") %>%
  mutate(Class = 8)


all <- bind_rows(M4, M8, S4, S8)
all_gender <- bind_rows(GM4, GM8, GS4, GS8)

all_data <- bind_rows(all, all_gender %>% mutate(Score = as.double(Score)))

write_csv2(all_data, "dane.csv")
