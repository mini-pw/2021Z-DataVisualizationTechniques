library(dplyr)
library(ggplot2)
library(ggrepel)
library(data.table)

data <- fread("https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/owid-covid-data.csv")

dataFiltered <- data %>% filter(continent == "Europe")

#countries <- dataFiltered %>% distinct(location)

countries <- c("Austria", "Belgium", "Bulgaria", "Czech Republic", 
                    "Denmark", "Spain", "Estonia", "Finland", "France", "United Kingdom",
                    "Croatia", "Hungary", "Ireland", "Iceland", "Italy", "Lithuania", 
                    "Luxembourg", "Latvia", "Norway", "Poland", "Portugal", "Slovakia", "Slovenia")

dataFiltered <- dataFiltered %>% filter(is.element(location, countries))

dataFiltered <- dataFiltered %>% select(location, date, new_deaths, weekly_hosp_admissions)

dataFiltered$date <- as.POSIXct(dataFiltered$date, tz="CET")

dataFiltered <- dataFiltered %>% 
  mutate(week = strftime(date, format = "%V"))

dataFiltered <- dataFiltered %>%
  group_by(week) %>%
  mutate(weekly_deaths = sum(new_deaths, na.rm = TRUE)) %>% ungroup()


tmp <- dataFiltered %>% 
  filter(!is.na(weekly_hosp_admissions)) %>%
  group_by(week) %>%
  summarise(hosp = sum(weekly_hosp_admissions))

weekly_deaths <- dataFiltered %>%
  filter(!is.na(weekly_hosp_admissions)) %>%
  distinct(week, weekly_deaths)
  
tmp <- inner_join(tmp, weekly_deaths, by = "week")

tmp <- tmp %>% ungroup() %>% 
  mutate(date = as.Date(paste(2020, week, 1, sep="-"), "%Y-%U-%u"))

#--------------------------Wykres 1--------------------------------------------
ggplot() +
  geom_line(data = tmp, aes(x = date, y = hosp, colour = "orange3"), group = 1) +
  geom_line(data = tmp, aes(x = date, y = weekly_deaths, colour = "dodgerblue3"), group = 1) +
  labs(title = "Total hospitalizations and deaths in selected European countries\n on a given week during the pandemic",
       y = "total cases",
       x = element_blank(),
       color = "cases type") +
  scale_color_manual(labels = c("deaths", "hospitalizations"),
                     values = c("dodgerblue3", "orange3")) + 
  scale_x_date(breaks = "1 months", expand = c(0, 0), date_labels = "%b") +
  theme_bw() +
  theme(legend.position = c(0.55, 0.7)) +
  scale_y_continuous(expand = c(0, 0)) +
  guides(fill = guide_legend(reverse = TRUE))




