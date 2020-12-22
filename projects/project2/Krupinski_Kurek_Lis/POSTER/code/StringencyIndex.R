covid <- read.csv("data/owid-covid-data.csv")
LOT <- read.csv("data/LOT.csv")
lotnisko <- read.csv("data/lotnisko.csv")
loty <- read.csv("data/loty.csv")
hotel <- read.csv("data/hotel.csv")

#obostrzenia
flags <- read.csv("data/OxCGRT_latest.csv")
flags <- dplyr::filter(flags, CountryName == "Poland")
flags <- dplyr::select(flags, "Date", "C7_Restrictions.on.internal.movement", "C8_International.travel.controls")

covidPolishSI <- dplyr::filter(covid, location == "Poland")
covidPolishSI <- dplyr::select(covidPolishSI, "date", "stringency_index")
covidPolishSI = covidPolishSI[-1,]

#średnia popularnosci synonimów
LOT[,2] = (LOT[,2] + lotnisko[,2] + loty[,2]) / 3

#łączenie danych
covidPolishSILOT <- dplyr::inner_join(covidPolishSI, LOT, by = c("date" = "Day"))
covidPolishSILOT[,1] = as.Date(covidPolishSILOT[,1])
covidPolishSIHotel <- dplyr::inner_join(covidPolishSI, hotel, by = c("date" = "Day"))
covidPolishSIHotel[,1] = as.Date(covidPolishSIHotel[,1])


library(ggplot2)

#wykresy, wszystkie eksportujemy ręcznie do 1952x600 pikseli

plotHotels <- function() {
  ggplot(covidPolishSIHotel, aes(x = date)) +
    geom_bar(aes(y = hotel, fill = "interest in\n keywords"), stat = "identity", width = 1) +
    geom_line(aes(y = stringency_index, group = 1, color = "stringency index"), size = 1.25) +
    theme_classic() +
    theme(text = element_text(size = 20), plot.title = element_text(hjust = 0.5), axis.ticks.length=unit(.25, "cm")) +
    scale_y_continuous(limits = c(0, 100), labels = function(x) paste(x, '%', sep="")) +
    ggplot2::labs(title = "Interest in hotels",x = "", y = "") +
    scale_x_date(date_breaks = "1 month", date_minor_breaks = "1 day", date_labels = "%e %b", expand=c(0,0)) +
    scale_fill_manual("",values="#55bbc0") +
    theme(legend.key=element_blank(),
          legend.title=element_blank()) +
    geom_curve(
      x = as.Date("2020-05-10"),
      xend = as.Date("2020-05-30"),
      y = 63,
      yend = 60,
      lineend = "butt",
      size = 1.5, arrow = arrow(length = unit(0.3, "inches"))
    ) +
    annotate("text", size = 5, x = as.Date("2020-05-05"), y = 69,
             label = "internal movement restrictions\nhave been lifted")
}

plotAirports <- function() {
  ggplot(covidPolishSILOT, aes(x = date)) +
    geom_bar(aes(y = LOT, fill = "interest in\n keywords"), stat = "identity", width = 1) +
    geom_line(aes(y = stringency_index, group = 1, color = "stringency index"), size = 1.25) +
    theme_classic() +
    theme(text = element_text(size = 20), plot.title = element_text(hjust = 0.5), axis.ticks.length=unit(.25, "cm")) +
    scale_y_continuous(limits = c(0, 100), labels = function(x) paste(x, '%', sep="")) +
    ggplot2::labs(title = "Interest in airports",x = "", y = "") +
    scale_x_date(date_breaks = "1 month", date_minor_breaks = "1 day", date_labels = "%e %b", expand=c(0,0)) +
    scale_fill_manual("",values="#55bbc0") +
    theme(legend.key=element_blank(),
          legend.title=element_blank()) +
    geom_curve(
      x = as.Date("2020-04-10"),
      xend = as.Date("2020-03-16"),
      y = 47,
      yend = 50,
      lineend = "butt",
      size = 1.5, arrow = arrow(length = unit(0.3, "inches"))
    ) +
    annotate("text", size = 5, x = as.Date("2020-04-30"), y = 47,
             label = "total border closure\nfor foreign travellers and\nrecommendation not to travel\nbetween regions/cities") +
    geom_curve(
      x = as.Date("2020-09-25"),
      xend = as.Date("2020-10-22"),
      y = 63,
      yend = 60,
      lineend = "butt",
      size = 1.5, arrow = arrow(length = unit(0.3, "inches"))
    ) +
    annotate("text", size = 5, x = as.Date("2020-09-20"), y = 70,
             label = "recommendation not to travel\nbetween regions/cities")
}
plotHotels()
plotAirports()
