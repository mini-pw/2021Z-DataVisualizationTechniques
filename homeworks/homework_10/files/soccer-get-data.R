library(DBI)
library(RSQLite)
library(dplyr)

# trzeba pobrac z https://www.kaggle.com/hugomathien/soccer
soccer_con <- dbConnect(RSQLite::SQLite(), dbname = "./homeworks/homework_10/files/database.sqlite")

# Lista tabel
dbListTables(soccer_con)

# Zapytania SQL

## Panstwa
dbGetQuery(soccer_con, "select * from Country")

## Ligi
dbGetQuery(soccer_con, "select * from League limit 5")

## Sezony
season_dat <- dbGetQuery(soccer_con, "select * from Match where league_id is 1729") %>% 
  filter(season %in% c("2014/2015", "2015/2016")) %>% 
  select(season, stage, date, home_team_api_id, away_team_api_id, home_team_goal, away_team_goal)

## Druzyny
teams <- dbGetQuery(soccer_con, "select team_api_id, team_long_name from Team")

## Dane dotyczace Polski
PL_dat <- inner_join(season_dat, teams, by = c("home_team_api_id" = "team_api_id")) %>% 
  rename(home_team = team_long_name) %>% 
  inner_join(teams, by = c("away_team_api_id" = "team_api_id")) %>% 
  rename(away_team = team_long_name) %>% 
  select(-home_team_api_id, -away_team_api_id)

## Zapis do pliku
write.csv2(PL_dat, file = "./homeworks/homework_10/files/PL_dat.csv", row.names = FALSE)
