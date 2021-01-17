library(tidyverse)
library("readxl")
library(ggplot2)

# ----------------MATH-----------------------
M4results <- read_xlsx("data/mathG4/1-1_achievement-results-M4.xlsx", skip=4)%>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()%>%
  mutate(pick=FALSE)%>%
  mutate(Country = as.factor(Country))%>%
  filter(Country != "TIMSS Scale Centerpoint")

M4trends <- read_xlsx("data/mathG4/1-3_achievement-trends-M4.xlsx", skip = 4)%>%
  select(Country, `2019`, `2015`, `2011`, `2007`, `2003`, `1995`)%>%
  filter(!is.na(Country))%>%
  mutate(pick=FALSE)%>%
  gather(`1995`, `2003`,`2007`,`2011`,`2015`,`2019`,
         key = "year", value = "Score")%>%
  mutate(year = as.numeric(year), Country = as.factor(Country))%>%
  filter(!is.na(Score))%>%
  filter(Country != "TIMSS Scale Centerpoint")

M8results <- read_xlsx("data/mathG8/3-1_achievement-results-M8.xlsx", skip=4)%>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()%>%
  mutate(pick=FALSE)%>%
  mutate(Country = as.factor(Country))%>%
  filter(Country != "TIMSS Scale Centerpoint")

M8trends <- read_xlsx("data/mathG8/3-3_achievement-trends-M8.xlsx", skip = 4)%>%
  select(Country, `2019`, `2015`, `2011`, `2007`, `2003`, `1995`)%>%
  filter(!is.na(Country))%>%
  mutate(pick=FALSE)%>%
  gather(`1995`, `2003`,`2007`,`2011`,`2015`,`2019`,
         key = "year", value = "Score")%>%
  mutate(year = as.numeric(year), Country = as.factor(Country))%>%
  filter(!is.na(Score))%>%
  filter(Country != "TIMSS Scale Centerpoint")

# -----------------SCIENCE--------------------
S4results <- read_xlsx("data/scienceG4/2-1_achievement-results-S4.xlsx", skip=4)%>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()%>%
  mutate(pick=FALSE)%>%
  mutate(Country = as.factor(Country))%>%
  filter(Country != "TIMSS Scale Centerpoint")

S4trends <- read_xlsx("data/scienceG4/2-3_achievement-trends-S4.xlsx", skip = 4)%>%
  select(Country, `2019`, `2015`, `2011`, `2007`, `2003`, `1995`)%>%
  filter(!is.na(Country))%>%
  mutate(pick=FALSE)%>%
  gather(`1995`, `2003`,`2007`,`2011`,`2015`,`2019`,
         key = "year", value = "Score")%>%
  mutate(year = as.numeric(year), Country = as.factor(Country))%>%
  filter(!is.na(Score))%>%
  filter(Country != "TIMSS Scale Centerpoint")

S8results <- read_xlsx("data/scienceG8/4-1_achievement-results-S8.xlsx", skip=4)%>%
  select(3, 5) %>%
  rename("Score" = "Average \r\nScale Score") %>%
  na.omit()%>%
  mutate(pick=FALSE)%>%
  mutate(Country = as.factor(Country))%>%
  filter(Country != "TIMSS Scale Centerpoint")

S8trends <- read_xlsx("data/scienceG8/4-3_achievement-trends-S8.xlsx", skip = 4)%>%
  select(Country, `2019`, `2015`, `2011`, `2007`, `2003`, `1995`)%>%
  filter(!is.na(Country))%>%
  mutate(pick=FALSE)%>%
  gather(`1995`, `2003`,`2007`,`2011`,`2015`,`2019`,
         key = "year", value = "Score")%>%
  mutate(year = as.numeric(year), Country = as.factor(Country))%>%
  filter(!is.na(Score))%>%
  filter(Country != "TIMSS Scale Centerpoint")

pickCountry <- function(df, country_str_pick, country_str_click='None'){
  df$pick <- FALSE
  df$click <- FALSE
  df[df$Country==country_str_pick, 'pick'] <- TRUE
  df[df$Country==country_str_click, 'click'] <- TRUE
  df
}

# countries_to_choose <- intersect(intersect(M4results$Country,M8results$Country),
#                                  intersect(S4results$Country, S8results$Country))

M4distribution <- read_xlsx("data/mathG4/1-1_achievement-results-M4.xlsx", skip=5)%>%
  .[,c(3,5,9,10,11,12,13,14)]
colnames(M4distribution) <- c("Country", "avg", "x5th_p", "x25th_p","x95_conf_1", "x95_conf_2", "x75th_p", "x95th_p")
M4distribution <- M4distribution%>%
  filter(!is.na(Country))%>%
  mutate_at(vars(-("Country")), as.double)%>%
  filter(Country != "TIMSS Scale Centerpoint")

M8distribution <- read_xlsx("data/mathG8/3-1_achievement-results-M8.xlsx", skip=5)%>%
  .[,c(3,5,9,10,11,12,13,14)]
colnames(M8distribution) <- c("Country", "avg", "x5th_p", "x25th_p","x95_conf_1", "x95_conf_2", "x75th_p", "x95th_p")
M8distribution <- M8distribution%>%
  filter(!is.na(Country))%>%
  mutate_at(vars(-("Country")), as.double)%>%
  filter(Country != "TIMSS Scale Centerpoint")

S4distribution <- read_xlsx("data/scienceG4/2-1_achievement-results-S4.xlsx", skip=5)%>%
  .[,c(3,5,9,10,11,12,13,14)]
colnames(S4distribution) <- c("Country", "avg", "x5th_p", "x25th_p","x95_conf_1", "x95_conf_2", "x75th_p", "x95th_p")
S4distribution <- S4distribution%>%
  filter(!is.na(Country))%>%
  mutate_at(vars(-("Country")), as.double)%>%
  filter(Country != "TIMSS Scale Centerpoint")

S8distribution <- read_xlsx("data/scienceG8/4-1_achievement-results-S8.xlsx", skip=5)%>%
  .[,c(3,5,9,10,11,12,13,14)]
colnames(S8distribution) <- c("Country", "avg", "x5th_p", "x25th_p","x95_conf_1", "x95_conf_2", "x75th_p", "x95th_p")
S8distribution <- S8distribution%>%
  filter(!is.na(Country))%>%
  mutate_at(vars(-("Country")), as.double)%>%
  filter(Country != "TIMSS Scale Centerpoint")

