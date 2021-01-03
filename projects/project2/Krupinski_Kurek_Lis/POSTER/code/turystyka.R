library(readr)
library(ggplot2)
library(readxl)
library(dplyr)
library(RColorBrewer)

## Wczytanie i przygotowanie ramki danych
wczytaj <- function() {
  t <- read.csv(file = 'data/nights1.tsv', sep = '\t', header = TRUE)
  
  firstcolumn <- t %>%
    rename(country = freq.c_resid.unit.nace_r2.geo.TIME_PERIOD) %>%
    mutate_all(funs(gsub("M,FOR,NR,I551-I553,", "", .))) %>%
    select(country)
  
  turystyka <- t %>%
    rename(country = freq.c_resid.unit.nace_r2.geo.TIME_PERIOD) %>%
    mutate_all(funs(gsub("b", "", .))) %>%
    mutate_all(funs(gsub("u", "", .))) %>%
    mutate_all(funs(gsub(":", "0", .))) %>%
    mutate_all(funs(gsub("e", "", .))) %>%
    mutate_if(is.character,as.numeric) %>%
    replace("country", firstcolumn) 
}
wczytaj()

#Wybór danych dla krajóW, w których zaobserwowaliśmy najciekawsze zależności
niemcy <- turystyka %>%
  filter(country == "DE")

norway <- turystyka %>%
  filter(country == "NO")

netherlands <- turystyka %>%
  filter(country == "NL")


oblicz_srednia <- function(kraj){
  kraj <- kraj %>%
    select(!(contains("x2020")))
  miesiace <- c(".01", ".02", ".03", ".04", ".05", ".06", ".07", ".08", ".09", ".10", ".11",".12")
  srednia = 0
  for (i in 1:12){
    
    srednia[i] <- kraj %>%
    select(contains(miesiace[i])) %>%
    rowMeans()
  }
  srednia
}

niemcy
oblicz_srednia(niemcy)

ramka_do_wykresu <- function(kraj){data.frame(miesiace = rep(c(1:12), 7), 
                              liczby = c(t(oblicz_srednia(kraj)), 
                                t(select(kraj, contains("x2020"))), t(c(NaN, NaN)), 
                                t(select(kraj, contains("x2015"))), t(select(kraj, contains("x2016"))),
                                t(select(kraj, contains("x2017"))), t(select(kraj, contains("x2018"))), 
                                t(select(kraj, contains("x2019")))),
                              year = rep(c("2015-2019", "2020", "2015", "2016", "2017", "2018", "2019"), each = 12))
}


niemcy_ramka <- ramka_do_wykresu(niemcy)
dplyr::all_equal(ramka_do_wykresu(niemcy), niemcy_ramka)
netherlands_ramka <- ramka_do_wykresu(netherlands)
brewer.pal(9, "Reds")
display.brewer.all()

generuj_wykres <- function(kraj) {
  ggplot(kraj, aes(x = miesiace, y = (liczby*10^-6), color = year))+
    geom_line(size= c(rep(0.7, 12), rep(1.5, 12), rep(0.7, 48),  rep(1.5, 12)), alpha = c(rep(1, 12), rep(1, 12), rep(1, 12), rep(1, 12), rep(1, 12), rep(1, 12),  rep(1, 12)))+
    scale_x_continuous(breaks = scales::pretty_breaks(n = 12)) +
    scale_y_continuous(breaks = scales::pretty_breaks(n = 6)) +
    ylab("total nights spent in hotels [mln]") +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5))+
    xlab("months")+
    scale_color_manual(values = c( "#B0B0B0","#f77a71","#B8B8B8","#909090","#696969","#505050", "#55bbc0"))+
    theme(text = element_text(size = 20))
  
}

generuj_wykres(niemcy_ramka) + ggtitle("Number of visitors in hotels in Germany")
generuj_wykres(netherlands_ramka) + ggtitle("Number of visitors in hotels in the Netherlands")
