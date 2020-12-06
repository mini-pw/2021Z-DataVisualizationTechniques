library(dplyr)
library(ggplot2)
library(ggrepel)
data <- read.csv("covidData.csv")


dataFiltered <- data %>% filter(continent == "Europe")

tmp <- dataFiltered %>% ungroup() %>% 
  filter(!is.na(weekly_hosp_admissions)) %>%
  group_by(date) %>%
  summarise(hosp = mean(weekly_hosp_admissions),
            deaths = mean(new_deaths, na.rm = TRUE))
  


#--------------------------Wykres 1--------------------------------------------
ggplot() +
  geom_line(data = tmp, aes(x = date, y = hosp), group = 1, colour = 'red') + 
  geom_line(data = tmp, aes(x = date, y = deaths*10), group = 1, colour = 'blue') +
  theme(axis.text.x = element_blank()) +
  scale_y_continuous(
    "hospitalizations", 
    sec.axis = sec_axis(~./10, name = "deaths")) + 
  labs(title = "Hospitalizations and deaths") +
  scale_color_manual(values = c("red", "blue"))


#--------------------------Wykres 2---------------------------------------------------

tmp <- dataFiltered %>% ungroup() %>% 
  group_by(location) %>%
  summarise(cases = max(total_cases, na.rm = TRUE), 
            hosp = mean(weekly_hosp_admissions, na.rm = TRUE),
            deaths = max(total_deaths, na.rm = TRUE))

ggplot(data=tmp, aes(x = hosp, y = cases, label = location)) + 
  geom_point(aes(size = deaths), color = case_when(tmp$cases > 10**6 ~ "#d95f02", 
                                                   tmp$cases < 2*10**5 ~ "#64f448",
                                                   TRUE ~ "#7570b3")) +
  geom_label_repel(data = subset(tmp, deaths > 10000),
                   aes(label = location),
                   box.padding   = 0.35, 
                   point.padding = 0.5,
                   segment.color = 'grey50') +
  labs(title = "How do cases and hospitalizations\ninfluence deaths")




