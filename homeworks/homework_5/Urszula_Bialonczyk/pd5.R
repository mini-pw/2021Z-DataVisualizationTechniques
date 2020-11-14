library(ggplot2)
powody <- rep(c("Wypędzenie", "Wymeldowanie", "Pozostawienie\nrodzinie", "Eksmisja",
            "Bezrobocie", "Zadłużenie", "Opuszczenie\nwięzienia", "Ucieczka\nprzed przemocą domową",
            "Utrata noclegów\nw byłej pracy", "Opuszczenie\ndomu dziecka"), 3)
plec <- c(rep("Kobieta", 10), rep("Mezczyzna", 10), rep("Ogolem", 10))
procent_plec <- c(15.9, 13.7, 9.9, 9.6, 9, 5.8, 1, 6.7, 0.5, 0.5, 19.9, 15.3, 11.8, 
                  11.3, 9.7, 5.1, 3.6, 1.2, 0.9, 0.5, 19.3, 15, 11.5, 11, 9.6, 5.2, 3.2, 2.1, 0.8, 0.5)

dane = data.frame(powody, plec, procent_plec)

ggplot(dane, aes(fill=plec, y=procent_plec, x=powody)) +
  geom_bar(position="dodge", stat="identity") +
  ggtitle("Przyczyny bezdomności według płci osób bezdomnych I kategorii w 2011 roku") +
  theme(plot.title = element_text(hjust = 0.5))

