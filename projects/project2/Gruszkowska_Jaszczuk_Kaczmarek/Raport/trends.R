library(dplyr)
library(data.table)
library(ggplot2)

dane <- read.table("multiTimeline.csv",header=TRUE, sep=",")
nowe_przypadki <- read.table("Dane.csv",header=TRUE, sep=";")
nowe <-data.frame(nowe_przypadki$Data, nowe_przypadki$Nowe.przypadki)
colnames(nowe) <- c("date", "ilosc")


nowe$tydzien <- format(as.Date(nowe$date),"%W")
dane$tydzien <- format(as.Date(dane$Tydzien),"%W")
new<- data.frame(nowe$tydzien,nowe$ilosc)
new<- new%>%
  group_by(nowe.tydzien)%>%
  summarise(suma = sum(nowe.ilosc))
colnames(new)<- c("tydzien","suma")


wynikowe<- inner_join(dane,new,by='tydzien')
wynikowe$Tydzien<- as.Date(wynikowe$Tydzien)

wykres<-ggplot(rbind(data.frame(x = wynikowe$Tydzien,y = (wynikowe$koronawirus...Polska.)*1800,type = "wyszukania"),
                     data.frame(x = wynikowe$Tydzien,y = wynikowe$suma.y,type = "nowe przypadki zachorowania")),
               aes(x=x,y=y,color=type))+
  geom_smooth()+
  geom_point()+
  scale_y_continuous(
    name="Suma przypadków w tygodniu",
    sec.axis = sec_axis(~./1800,name="trend wyszukañ frazy koronawirus w tygodniu")
  )+
  scale_color_manual(values = c("wyszukania" = '#00A4E6',
                                "nowe przypadki zachorowania" = '#fa9fb5'
                                ))+
  xlab("Tydzieñ")+
  ggtitle("Porównanie iloœci przypadków zachorowañ do iloœci wyszukañ frazy koronawirus w Google")+
  theme_light()+
  theme(
    axis.line.y = element_line(color = "#fa9fb5"),
    axis.line.y.right = element_line(color = "#00A4E6")
  )
  
  
wykres

