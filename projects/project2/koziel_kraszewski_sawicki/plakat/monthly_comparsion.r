library('dplyr')
library('ggplot2')
library('ggthemes')
library('patchwork')

covid <- read_csv("https://covid.ourworldindata.org/data/owid-covid-data.csv")
covid <- filter(covid, location=="Poland")

aqcin <- read.csv("waqi-covid19-airqualitydata-2020.csv")
aqcin <- filter(aqcin, Country=="PL")


ggplot(covid, aes(x = date)) +
  geom_line(aes(y = new_cases), color = "#AF8DC3", size = 2) +
  scale_y_continuous(name = "new cases",
                     limits = c(0, 1000), expand = expansion(mult = c(0, 0))
  ) +
  scale_x_date(date_labels = "%d.%m",
               limits = as.Date(c("2020-08-04", "2020-08-25"))) +
  labs(title = "Number of new cases in Poland in August",
       x = "date") +
  theme_bw(base_family = "Crimson Pro",
           base_size = 18) +
  theme(plot.title = element_text(face = 'bold')) -> p1

#------------------------------------------------------
#pm10
aqcin %>%
  filter(Specie=="pm10") %>%
  group_by(Date) %>%
  summarise(pm10 = mean(median))  -> data

data$Date = as.Date(data$Date)

data %>%
  inner_join(covid, by = c("Date" = "date")) %>%
  select(Date, pm10, new_cases) -> data

ggplot(data, aes(x = Date)) +
  geom_line(aes(y = pm10), color = "#7FBF7B", size = 2) +
  scale_y_continuous(name = "PM10 [AQI]",
                     limits = c(0,33), expand = expansion(mult = c(0, 0))
  ) +
  scale_x_date(date_labels = "%d.%m",
               limits = as.Date(c("2020-08-04", "2020-08-25"))) +
  labs(title = "Avarage PM10 value in Poland in August",
       x = "date") +
  theme_bw(base_family = "Crimson Pro",
           base_size = 18) +
  theme(plot.title = element_text(face = 'bold')) -> p2

#------------------------------------------------------
#pm25
aqcin %>%
  filter(Specie=="pm25") %>%
  group_by(Date) %>%
  summarise(pm25 = mean(median))  -> data

data$Date = as.Date(data$Date)

data %>%
  inner_join(covid, by = c("Date" = "date")) %>%
  select(Date, pm25, new_cases) -> data

ggplot(data, aes(x = Date)) +
  geom_line(aes(y = pm25), color = "#7FBF7B", size = 2) +
  scale_y_continuous(name = "PM2.5 [AQI]",
                     limits = c(0,66), expand = expansion(mult = c(0, 0))
  ) +
  scale_x_date(date_labels = "%d.%m",
               limits = as.Date(c("2020-08-04", "2020-08-25"))) +
  labs(title = "Avarage PM2.5 value in Poland in August",
       x = "date") +
  theme_bw(base_family = "Crimson Pro",
           base_size = 18) +
  theme(plot.title = element_text(face = 'bold')) -> p3


#------------------------------------------------------
#o3
aqcin %>%
  filter(Specie=="o3") %>%
  group_by(Date) %>%
  summarise(o3 = mean(median))  -> data

data$Date = as.Date(data$Date)

data %>%
  inner_join(covid, by = c("Date" = "date")) %>%
  select(Date, o3, new_cases) -> data

ggplot(data, aes(x = Date)) +
  geom_line(aes(y = o3), color = "#7FBF7B", size = 2) +
  scale_y_continuous(name = "O3 [AQI]",
                     limits = c(0,40), expand = expansion(mult = c(0, 0))
  ) +
  scale_x_date(date_labels = "%d.%m",
               limits = as.Date(c("2020-08-04", "2020-08-25"))) +
  labs(title = "Avarage O3 value in Poland in August",
       x = "date") +
  theme_bw(base_family = "Crimson Pro",
           base_size = 18) +
  theme(plot.title = element_text(face = 'bold')) -> p4

wrap_plots(p1,p2,p3,p4, ncol = 2, nrow = 2)