library(XML)
library(methods)
library(ggplot2)
library(dplyr)
library(tidyr)
library(rjson)
library(data.table)
library(maps)
library(readr)
library(data.table)
library(RColorBrewer)

# data from aqcin.org

# how to download csv ?

# curl --compressed -o waqi-covid-2020.csv   https://aqicn.org/data-platform/covid19/report/19780-07745f90/2020
# curl --compressed -o waqi-covid-2019Q1.csv https://aqicn.org/data-platform/covid19/report/19780-07745f90/2019Q1
# curl --compressed -o waqi-covid-2019Q2.csv https://aqicn.org/data-platform/covid19/report/19780-07745f90/2019Q2
# curl --compressed -o waqi-covid-2019Q3.csv https://aqicn.org/data-platform/covid19/report/19780-07745f90/2019Q3
# curl --compressed -o waqi-covid-2019Q4.csv https://aqicn.org/data-platform/covid19/report/19780-07745f90/2019Q4
# curl --compressed -o waqi-covid-2018H1.csv https://aqicn.org/data-platform/covid19/report/19780-07745f90/2018H1
# curl --compressed -o waqi-covid-2017H1.csv https://aqicn.org/data-platform/covid19/report/19780-07745f90/2017H1
# curl --compressed -o waqi-covid-2016H1.csv https://aqicn.org/data-platform/covid19/report/19780-07745f90/2016H1
# curl --compressed -o waqi-covid-2015H1.csv https://aqicn.org/data-platform/covid19/report/19780-07745f90/2015H1

raw_data <- read_csv("waqi-covid-2020.csv", skip = 4) # skip headers
raw_data <- rbind(raw_data, read_csv("waqi-covid-2019Q1.csv", skip = 4))
raw_data <- rbind(raw_data, read_csv("waqi-covid-2019Q2.csv", skip = 4))
raw_data <- rbind(raw_data, read_csv("waqi-covid-2018H1.csv", skip = 4))
raw_data <- rbind(raw_data, read_csv("waqi-covid-2017H1.csv", skip = 4))
raw_data <- rbind(raw_data, read_csv("waqi-covid-2016H1.csv", skip = 4))

brewer.pal(3,"PRGn")

raw_data %>% 
  filter(Country == "PL") %>%
  filter(Specie == "no2") %>% 
  filter(City %in% c("Warsaw","Wrocław","Łódź","Gdańsk","Kraków","Poznań"))%>% 
  mutate(year = as.character(year(Date))) %>%
  arrange(Date) %>%
  distinct() %>%
  select(-c(min,max,count,variance))%>%
  pivot_wider(names_from = City, values_from = median)-> pol_co_raw

pol_co_rolling_raw <- cbind(pol_co_raw,frollmean(pol_co_raw[,5:10],n=7)) # 7 day rolling avarage
colnames(pol_co_rolling_raw)[11:16] <- paste(colnames(pol_co_rolling_raw)[5:10],"_rolling")
pol_co_rolling_raw %>% select(-(5:10)) -> pol_co_rolling
colnames(pol_co_rolling)[5:10] <- colnames(pol_co_rolling_raw)[5:10]

Sys.setlocale("LC_TIME", "C") # months in English
pol_co_rolling %>%
  pivot_longer(cols = 5:10,names_to= "City", values_to = "median") %>%
  mutate(day = as.Date(format(Date, format = "%d-%m"),format = "%d-%m"))%>%
  filter(day<as.Date("01.07.2020", format = "%d.%m.%Y"))%>%
  ggplot(aes(x = day)) + 
  geom_line(aes(y = median, group = year, color = year)) +
  geom_vline(xintercept = as.Date("04.03.2020",format = "%d.%m.%Y"), color = "#AF8DC3", size = 1.2) +# patient zero in PL
  facet_wrap(~City) +
  ggtitle("NO2 in polish cities") +
  scale_color_manual(values = c("gray67","gray67","gray67","gray67","#7FBF7B")) +
  theme_bw(base_size = 18)+
  ylab("7 day rolling avarage of daily values [AQI]")+
  xlab("Date") +
  labs(caption = "purple line - patient \'zero\' diagnosed in Poland \ngreen line - 2020   grey lines - 2016-2019")+
  theme(legend.position = "none",
        plot.caption.position = "plot",
        strip.background =element_rect(fill="white"),
        plot.title = element_text(face = "bold"))
