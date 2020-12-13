library(dplyr)
library(ggplot2)
library(data.table)
library(tidyr)


#-----------------------------------dane o śmierci ogółem----------------------------------------------#

dane <- read.csv("https://raw.githubusercontent.com/ulabialonczyk/Datasets/main/excess-mortality-raw-death-count.csv")
head(dane)
colnames(dane)[c(4,5)] <- c("Deaths_2020_all_ages", "Average_deaths_2015_2019_all_ages")

kraje = c("Austria", "Belgium", "Bulgaria", "Czech Republic", "Denmark", "Spain", "Estonia", "Finland", "France", "England & Wales",
          "Croatia", "Hungary", "Northern Ireland", "Iceland", "Italy", "Lithuania", "Luxembourg", "Latvia", "Norway", "Poland", "Portugal",
          "Slovakia", "Slovenia")

dane = dane %>% filter(Entity %in% kraje)
dane$Date <- as.IDate(dane$Date)

dane = dane %>% filter(month(Date)==10) %>% select(Entity, Deaths_2020_all_ages, Average_deaths_2015_2019_all_ages)

#brak danych o Slovenii, Francji i Wloszech; 

dane = dane %>% filter(!(Entity %in% c("Slovenia", "Italy", "France")))

#Na Słowacji brakuje danych z ostatniego tygodnia pazdziernika 2020, zastepuje je srednia z poprzednich tygodni

dane[76, 2] <- mean(dane[73:75, 2])

dane = dane %>% group_by(Entity) %>% summarise(Sum_2020=sum(Deaths_2020_all_ages), Average_2015_2019=sum(Average_deaths_2015_2019_all_ages))
dane$Entity <- as.character(dane$Entity)
dane[7, 1] <- "United Kingdom"
dane[15, 1] <- "Ireland"



#---------------------------- dodajemy dane o smierci z powodu covid---------------------------------------#
dane2=fread("https://covid.ourworldindata.org/data/owid-covid-data.csv")

kraje2 = c("Austria", "Belgium", "Bulgaria", "Czechia", "Denmark", "Spain", "Estonia", "Finland", "United Kingdom",
           "Croatia", "Hungary", "Ireland", "Iceland", "Lithuania", "Luxembourg", "Latvia", "Norway", "Poland", "Portugal",
           "Slovakia")
dane2 = dane2[dane2$location %in% kraje2, c(3,4,8,9)]
dane2$date = as.IDate(dane2$date)
dane2 = dane2[month(dane2$date)==10 & year(dane2$date)==2020 & (mday(dane2$date)==1 | mday(dane2$date)==30), ]



covid_deaths = numeric()
country=c()
for(i in seq(2, 40, 2)){
  covid_deaths=c(covid_deaths, dane2$total_deaths[i]-dane2$total_deaths[i-1])
  country=c(country, dane2$location[i])
  
}
dane2 = data.table(Entity=country, Deaths_due_to_covid=covid_deaths)
dane2$Entity <- as.character(dane2$Entity)

# muszę nazwac tak jak było w pierwszym zbiorze danych (w tym Czechy to Czechia)
dane2$Entity[5] <- "Czech Republic"

dane_full = merge(dane, dane2, on=Entity)
dane_full = dane_full %>% mutate(Sum_2020_without_covid = Sum_2020 - Deaths_due_to_covid)

#postac szeroka danych

wide = gather(dane_full[, -4], "When", "Number", "Average_2015_2019", "Sum_2020", "Sum_2020_without_covid", -Entity)
wide$When <- as.factor(wide$When)

# populacje - spisane ręcznie z google
wide$Population = rep(c(9045069, 11619816, 6928665, 4094038, 10722241, 5799640, 1329477, 5545596, 9652821, 342303, 
                        4973244, 1876751, 2702373, 632174, 5436637, 37840465, 10184326, 5462617, 46798331, 68077834), 3)
wide = wide %>% mutate(Number_per_milion = Number*1000000/Population)


#wykres caly 2020 vs poprzednie


ggplot(wide, aes(x=Entity, y=Number_per_milion, fill=When)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  scale_fill_manual(labels = c("Average deaths in 2015-2019", "Overall deaths in 2020", "Deaths in 2020\n excluding COVID deaths"), values=c("darkblue", "bisque", "brown4")) +theme_bw() +
  scale_y_continuous(expand=c(0,0)) +
  ggtitle("Deaths in October in the selected European countries") +
  ylab("Deaths per million") +
  xlab("Country") +
  theme(plot.title = element_text(hjust = 0.5, size = 20))+
  theme(axis.text.x = element_text(angle = 60, vjust=0.6, size = 12)) +
  theme(axis.title = element_text(size = 16))+
  theme(legend.title=element_text(size=14))
