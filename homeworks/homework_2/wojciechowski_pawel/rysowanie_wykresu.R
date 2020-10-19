library('ggplot2')
library('tibble')
library('dplyr')

surowe_dane <- read.csv('pd2/COVID-19 w Polsce - Sytuacja epidemiologiczna.csv', colClasses = rep("character",22))

dane <- as_tibble(surowe_dane) %>%
  select(Data, Liczba.osób.objętych.kwarantanną) %>%
  mutate(Data = as.Date(paste(Data, ".2020", sep = ""), format = "%d.%m.%Y"),
         Liczba.osób.objętych.kwarantanną = as.numeric(Liczba.osób.objętych.kwarantanną))
  

ggplot(dane[seq(1, dim(dane)[1], 5),], aes(x=Data, y=Liczba.osób.objętych.kwarantanną))+
  geom_col(fill="#4EB1B4")+
  scale_x_date(date_breaks = "1 month", date_labels = "%b")+
  scale_y_continuous(labels = scales::label_comma(),
                     breaks = seq(0,300000,25000))+
  theme_light()+
  theme(axis.title.x = element_blank(),
        plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1,1,1,1,"cm"))+
  labs(title="Osoby na kwarantannie COVID-19",
       y="Liczba osób objętych kwarantanną")
  
