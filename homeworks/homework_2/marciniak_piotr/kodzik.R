library(COVID19)
library(dplyr)


Poland <- covid19(country = "Poland", start = "2020-08-31", end = "2020-10-17", verbose=FALSE) %>%
  ungroup() %>%
  select(date, confirmed, deaths) %>%
  mutate(daily_confirmed = confirmed - lag(confirmed),
            daily_deaths = deaths - lag(deaths))  %>%
  select(date, daily_confirmed, daily_deaths) %>%
  add_row(date = as.Date("2020-10-16"), daily_confirmed = 7705, daily_deaths = 132) %>%
  filter(date > as.Date("2020-08-31"))