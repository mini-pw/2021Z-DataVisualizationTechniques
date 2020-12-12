covid <- read.csv("data/owid-covid-data.csv")
PKP <- read.csv("data/PKP.csv")
LOT <- read.csv("data/LOT.csv")
hotel <- read.csv("data/hotel.csv")

covidPolishSI <- dplyr::filter(covid, location == "Poland")
covidPolishSI <- dplyr::select(covidPolishSI, "date", "stringency_index")

covidPolishSIPKP <- dplyr::inner_join(covidPolishSI, PKP, by = c("date" = "Day"))
covidPolishSILOT <- dplyr::inner_join(covidPolishSI, LOT, by = c("date" = "Day"))
covidPolishSIHotel <- dplyr::inner_join(covidPolishSI, hotel, by = c("date" = "Day"))

library(ggplot2)

ggplot(covidPolishSIHotel, aes(x = date)) +
  geom_bar(aes(y = hotel), stat = "identity", width = 1, fill = "#55bbc0") +
  geom_line(aes(y = stringency_index, group = 1), color = "red", size = 1.25) +
  theme_classic() +
  theme(axis.text.x=element_blank()) +
  ggplot2::labs(title = "hotel",x = "", y = "")
