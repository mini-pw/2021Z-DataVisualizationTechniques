library(ggplot2)
library(dplyr)

Data <- data.frame("Dane" = c(1118, 584, 1064, 550, 1149, 557),
                   "Rok" = c(2017, 2017, 2018, 2018, 2019, 2019), 
                   "Płeć" = c("Mężczyźni", "Kobiety"), stringsAsFactors = FALSE)
ggplot(data = Data, aes(x = Rok, y = Dane, fill = Płeć)) + 
  geom_bar(stat = "identity", position = position_dodge()) + 
  ylab("Liczba zaginionych seniorów wdg. płci") + ggtitle("Statystyki zaginionych seniorów w latach 2017 - 2019") +
  geom_text(aes(label=Dane), vjust=1.6, color="black", position = position_dodge(0.9), size=3.5) + 
  theme(legend.position="bottom", plot.title = element_text(hjust = 0.5))