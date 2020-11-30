library(dplyr)
library(ggplot2)


dane <- read.csv(file = "change-visitors-parks-covid.csv") %>%
  filter(Entity == "Poland")%>%
  select(Date, parks)


dane$Date = as.Date(dane$Date)
head(dane)

p <- ggplot(dane, aes(x=Date, y=parks)) +
  geom_line( color="black") +
  ylab("Liczba osób odwiedzajcych\nparki i przestrzenie zewntrzne")+
  theme(axis.title.x = element_blank()) #usuniecie nazw osi

p
        


