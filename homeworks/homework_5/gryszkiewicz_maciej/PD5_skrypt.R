library(ggplot2)
library(dplyr)

DF <- read.csv("DF.csv")

DF %>%
  filter(Time == 2004, Employment.status == "Total employment") %>%
  select("Country", "Value") %>%
  arrange(Value) -> DF

DF$Country <- factor(DF$Country, levels = DF$Country)

ggplot(DF, aes(x = Country, y = Value)) +
  theme_bw() +
  geom_col(width = 0.78, fill = "dodgerblue3") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.3)) +
  xlab("") +
  ylab("godziny pracy") +
  ggtitle("Przeciętna roczna liczba godzin pracy w poszczególnych krajach")

