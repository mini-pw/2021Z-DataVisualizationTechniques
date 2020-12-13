library(readr)
library(ggplot2)
library(readxl)

turystyka <- read_delim("data/nights_in_hotels.csv", delim = ";;")
turystyka <- turystyka[11:50,]
turystyka[1, 2]  #
turystyka[1, 26] #wszędzie +24 i stąd obliczyć jedną średnią wartość
turystyka[,1]




# 9 - Niemcy
lata = seq(2, 200, 24) #przeskok do tego samego miesiąca w kolejnych latach
turystyka[9, c(1, 2, 3)]

turystyka[9, 122]

niemcy2020 <- turystyka[9, seq(122, 139, 2)]
uk2020 <- turystyka[32, seq(122, 139, 2)]
norway2020 <- turystyka[35, seq(122, 139, 2)]
netherlands2020 <- turystyka[23, seq(122, 139, 2)]
uk2020[1, 8] <- "0"
uk2020[1, 9] <- "0"

niemcy2019 <- turystyka[9, seq(98, 115, 2)]
uk2019 <- turystyka[32, seq(98, 115, 2)]
norway2019 <- turystyka[35, seq(98, 115, 2)]
netherlands2019 <- turystyka[23, seq(98, 115, 2)]
rok <- c(rep("2019", 9), rep("2020", 9))



for (i in 1:9){
  niemcy2020[i] <- gsub(" ", "", niemcy2020[i])
  niemcy2020[i] <- as.numeric(niemcy2020[i])
  niemcy2019[i] <- gsub(" ", "", niemcy2019[i])
  niemcy2019[i] <- as.numeric(niemcy2019[i])
  uk2020[i] <- gsub(" ", "", uk2020[i])
  uk2020[i] <- as.numeric(uk2020[i])
  uk2019[i] <- gsub(" ", "", uk2019[i])
  uk2019[i] <- as.numeric(uk2019[i])
  norway2020[i] <- gsub(" ", "", norway2020[i])
  norway2020[i] <- as.numeric(norway2020[i])
  norway2019[i] <- gsub(" ", "", norway2019[i])
  norway2019[i] <- as.numeric(norway2019[i])
  netherlands2020[i] <- gsub(" ", "", netherlands2020[i])
  netherlands2020[i] <- as.numeric(netherlands2020[i])
  netherlands2019[i] <- gsub(" ", "", netherlands2019[i])
  netherlands2019[i] <- as.numeric(netherlands2019[i])
  
}



n <- data.frame(rok, miesiace = 1:9, liczby = c(t(niemcy2019), t(niemcy2020)))
uk <- data.frame(rok, miesiace = 1:9, liczby = c(t(uk2019), t(uk2020)))
nor <- data.frame(rok, miesiace = 1:9, liczby = c(t(norway2019), t(norway2020)))
nth <- data.frame(rok, miesiace = 1:9, liczby = c(t(netherlands2019), t(netherlands2020)))



ggplot(n, aes(x = miesiace, y = liczby, color = rok))+
  geom_line(size=1.5) +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 12)) +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 6)) +
  ylab("passengers [mln]") +
  ggtitle("Number of visitors in hotels in Germany") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))



ggplot(uk, aes(x = miesiace, y = liczby, color = rok))+
  geom_line(size=1.5) +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 12)) +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 6)) +
  ylab("passengers [mln]") +
  ggtitle("Number of visitors in hotels in UK") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))



ggplot(nor, aes(x = miesiace, y = liczby, color = rok))+
  geom_line(size=1.5) +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 12)) +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 6)) +
  ylab("passengers [mln]") +
  ggtitle("Number of visitors in hotels in Norway") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))


ggplot(nth, aes(x = miesiace, y = liczby, color = rok))+
  geom_line(size=1.5) +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 12)) +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 6)) +
  ylab("passengers [mln]") +
  ggtitle("Number of visitors in hotels in Netherlands") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))
