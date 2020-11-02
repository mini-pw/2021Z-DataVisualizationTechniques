library(dplyr)
library(ggplot2)

wojew <- c("Dolnośląskie", "Kujawsko-Pomorskie", "Lubelskie", "Lubuskie", "Łódzkie", 
           "Małopolskie", "Mazowieckie", "Opolskie", "Podkarpackie", "Podlaskie", 
           "Pomorskie", "Śląskie", "Świętokrzyskie", "Warmińsko-Mazurskie", "Wielkopolskie",
           "Zachodniopomorskie","Dolnośląskie", "Kujawsko-Pomorskie", "Lubelskie", "Lubuskie", "Łódzkie", 
           "Małopolskie", "Mazowieckie", "Opolskie", "Podkarpackie", "Podlaskie", 
           "Pomorskie", "Śląskie", "Świętokrzyskie", "Warmińsko-Mazurskie", "Wielkopolskie",
           "Zachodniopomorskie")
typ <- c(rep("Miasto",16),rep("Wieś",16))
dane <- c(-38.4, -18.7, -14.0,-1.7,-76.0,14.1,69.1,-27.8,28.6,13.0,13.4,-149.8,-17.5,3.1,-9.0,7.2,46.4,47.0,-9.3,15.6,1.8,91.0,75.5,-21.0,-5.2,-19.2,82.8,37.3,0.8,20.7,104.5,17.5)

moje_dane <- data.table::data.table(Województwo = wojew, Miejsce = typ, Dane = dane)
ggplot(data = moje_dane, aes(x = Województwo, y = Dane, fill = Miejsce)) + geom_bar(stat = "identity", position = position_dodge()) + coord_flip() + ggtitle("Przyrost/ubytek ludności w latach 2002-2011") + scale_fill_manual(values = c("#f1a340", "#998ec3")) + ylab("Zmiana w setkach tysięcy")
