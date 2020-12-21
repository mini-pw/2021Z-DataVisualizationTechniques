library(dplyr)
library(ggridges)
library(ggplot2)
library(forcats)
library(tidyr)

# Works as of 12.12.2020
data_covid <- read.csv("https://covid.ourworldindata.org/data/owid-covid-data.csv",                 
         header = TRUE,        
         sep = ",",            
         quote = "\"",         
         dec = ".",           
         fill = TRUE,          
         comment.char = "",    
         encoding = "unknown") 
         
data_covid_europe_hosp <- data_covid %>% 
  filter(!is.na( hosp_patients)) %>%
  filter( continent == "Europe")
        
# Chosen countries so they match with the ones from the second plot
chosen_countries <- c("Austria", "Belgium", "Bulgaria", "Czech Republic", "Denmark", "Spain", "Estonia", "Finland", "United Kingdom",
                      "Croatia", "Hungary", "Ireland", "Iceland", "Lithuania", "Luxembourg", "Latvia", "Norway", "Poland", "Portugal",
                      "Slovakia")


data_for_death_plots <- data_covid_europe_hosp %>%
  select( location, date, new_deaths_smoothed_per_million, new_deaths_smoothed) %>%
  group_by( location) %>%
  drop_na() %>%
  mutate( summed_deaths_per_million = cumsum( new_deaths_smoothed_per_million),
          summed_deaths = cumsum( new_deaths_smoothed)) %>%
  mutate( total_deaths_per_million = max( summed_deaths_per_million),
          total_deaths             = max( summed_deaths)) %>%
  select( -summed_deaths_per_million, -summed_deaths) %>%
  ungroup() %>%
  mutate(date = as.POSIXct(date, tz = "CET")) %>%
  filter( date >= as.POSIXct("2020-02-26", tz = "CET"), 
          date <= as.POSIXct("2020-12-05", tz = "CET")) %>%
  filter( location %in% chosen_countries)
  


colors <- data_for_death_plots %>% 
  distinct( location) 
  

data_for_death_plots <- data_for_death_plots %>%
  mutate( colored = case_when(
    location %in% c("Spain", "Lithuania", "Malta", "Slovakia") ~ "orange3",
    TRUE ~ "dodgerblue3"
  )
  ) 
colors <- data_for_death_plots %>%
  distinct(total_deaths_per_million) %>%
  arrange( desc( total_deaths_per_million))

dates <- data_for_death_plots %>%
  filter( location == "Estonia") %>%
  select( date)

monthsNames <- c("Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")

ggplot( data_for_death_plots,
        aes( x = as.Date(date),
             y = fct_reorder( location, total_deaths_per_million),
             height = log( new_deaths_smoothed_per_million + 1)/log(10),
             group = location,
             fill = colored
        )
       ) +
  geom_ridgeline() + 
  xlab("") +
  ylab("") +
  ggtitle(
    "log_10(smoothed av. of deaths/million) in selected European countries"
    ) +
  scale_fill_manual(
    values = c( "dodgerblue2","orange3"),
    labels = c( "Sufficient", "Lacking"),
    guide = guide_legend(
      title = "Data"
    )
  ) +
  scale_x_date(breaks = "1 months",
               expand = c(0.02, 0),
               date_labels = "%b"
               ) +
  theme_bw() +
  theme(
        axis.ticks.x = element_blank(),
        legend.position = "top",
        legend.text = element_text(size=12),
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        title = element_text(size = 15),
        plot.title = element_text(hjust = 1)
  ) 




