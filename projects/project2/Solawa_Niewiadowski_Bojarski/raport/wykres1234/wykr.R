library(ggplot2)
library(dplyr)
library(readxl)
library(readr)
library(scales)

MIESIACE <- c("styczeń","luty","marzec","kwiecień","maj","czerwiec","lipiec","sierpień","wrzesień","październik","listopad","grudzień")

ConfCases <- read_csv("biweekly-confirmed-covid-19-cases.csv", 
                                              col_types = cols(`Biweekly cases` = col_number(), 
                                                               `Biweekly cases Annotations` = col_skip(), 
                                                               Date = col_date(format = "%Y-%m-%d")))
ConfCases <- ConfCases %>% filter(Code == "POL") %>% select(Date, `Biweekly cases`)

IntMovRes <- read_csv("internal-movement-covid.csv", 
                      col_types = cols(Date = col_date(format = "%Y-%m-%d"), 
                                       restrictions_internal_movements = col_integer()))
IntMovRes <- IntMovRes %>% filter(Code == "POL") %>% select(Date, restrictions_internal_movements)

ExtMovRes <- read_csv("international-travel-covid.csv", 
                      col_types = cols(Date = col_date(format = "%Y-%m-%d"), 
                                       international_travel_controls = col_integer()))
ExtMovRes <- ExtMovRes %>% filter(Code == "POL") %>% select(Date, international_travel_controls)

Turystyka <- read_excel("/Turstyka.xlsx", 
                        col_types = c("skip", "skip", "text", 
                                              "skip", "skip", "numeric", "numeric", 
                                              "skip", "skip"))
Turystyka <- Turystyka %>% select(Rok, Miesiące, Wartosc)
Turystyka2020 <- Turystyka %>% filter(Rok==2020)
Turystyka2020 <- Turystyka2020 %>% rename(Mies = Miesiące) %>% select(Mies, Wartosc)
Turystyka <- Turystyka %>% filter(Rok!=2020)

stacje_tranzytowe <- read_csv("visitors-transit-covid.csv", 
                                   col_types = cols(Date = col_date(format = "%Y-%m-%d")))
stacje_tranzytowe <- stacje_tranzytowe %>% filter(Code == "POL") %>% select(Date, transit_stations)

Aver20172019 <- aggregate(Turystyka[,3], list(Turystyka$Miesiące), mean)
Aver20172019 <- Aver20172019 %>% rename(Mies = Group.1, Srednia = Wartosc)

SredI20 <- merge(Aver20172019, Turystyka2020)
SredI20 <- SredI20 %>%
  mutate(Mies =  factor(Mies, levels = MIESIACE)) %>%
  arrange(Mies)   

#ggplot() +
#  geom_path(data = stacje_tranzytowe, aes(x=Date, y=transit_stations, group=1)) +
#  labs(x="",y="Liczba osób na stacjach tranzytowych\n względem początku roku (%)", color = " ") +
#  theme(legend.position = "none")

#ggplot() +
#    geom_path(data = ConfCases %>% filter(Date < "2020-09-01"), aes(x=Date, y=`Biweekly cases`, group=1)) +
#    labs(x="",y="Liczba potwierdzonych zakarzeń w tygodniu", color = " ") +
#    theme(legend.position = "none") +
#    scale_y_continuous(labels = comma)

#ggplot() +
#    geom_path(data = ConfCases, aes(x=Date, y=`Biweekly cases`, group=1)) +
#    labs(x="",y="Liczba potwierdzonych zakarzeń w tygodniu", color = " ") +
#    theme(legend.position = "none") +
#    scale_y_continuous(labels = comma)


#ggplot() +
#  geom_path(data = SredI20, aes(x=Mies, y=Srednia, group=1, color="blue")) +
#  geom_path(data = SredI20, aes(x=Mies, y=Wartosc, group=1, color="red")) +
#  ylim(0, NA) +
#  scale_color_manual(labels = c("Średnia z lat\n2017-2019", "2020"), values = c("blue", "red")) +
#  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
#  scale_y_continuous(labels = comma) +
#  labs(x = "Miesiące", y="Liczba wynajmujących noclegi", color = " ")












