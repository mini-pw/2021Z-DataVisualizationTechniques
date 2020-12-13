library(dplyr)
library(data.table)
library(ggplot2)

a <- fread("MultiTimeline.csv")
b <- fread("multiTimeline_1.csv")
c <- fread("multiTimeline_2.csv")

colnames(a) <- c("Tydzien","Hiszpania ceny","Wlochy cena","Turcja ceny","Grecja ceny","Grecja wyjazd")
colnames(b) <- c("Tydzien","wycieczka","biura podrozy","wakacje last minute")
colnames(c) <- c("Tydzien","Turcja wyjazd","Bulgaria ceny")

wynikowe <- inner_join(a,b,by = "Tydzien")
wynikowe <- inner_join(wynikowe,c,by ="Tydzien")
wynikowe<- wynikowe%>%
  rowwise()%>%
  mutate(suma = sum(`Hiszpania ceny`,`Wlochy cena`,`Turcja ceny`,`Turcja ceny`,`Grecja ceny`,`Grecja wyjazd`,wycieczka,`biura podrozy`,`wakacje last minute`,`Turcja wyjazd`,`Bulgaria ceny`))


wynikowe$suma<- wynikowe$suma/592*100

write.csv(wynikowe,"wynikowe_test.csv")
#nanoszenie poprawek w excel
wynikowe2<- read.csv("wynikowe.csv")

wynikowe2$Tydzien_2020<- as.Date(wynikowe2$Tydzien_2020)
Sys.setlocale("LC_ALL", "English")

ggplot(wynikowe2,aes(x=Tydzien_2020,y = (Suma.2020/suma-1)))+
  geom_point(color = "white")+
  geom_smooth(color = "white")+
  theme_minimal()+
  ggtitle("Percentage change in Google trends ")+
  xlab("Date")+
  ylab("Change")+
  scale_y_continuous(labels = scales::percent)+
  theme(axis.title.x = element_text(size=15, face='bold', color = "orange"),
        axis.title.y = element_text(size=15, face='bold', color = "orange"),
        axis.text.x = element_text(size = 17, color = "orange"),
        axis.text.y = element_text(size = 17, color = "orange"),
        plot.title = element_text(hjust = 0.5, color = "orange", face = "bold", size = 30),
        panel.background = element_rect(fill = '#2e2b2b', colour = 'orange'),
        plot.background = element_rect(fill="#2e2b2b"),
        panel.grid.major = element_line(colour = "orange"),
        panel.grid.minor = element_line(colour = "orange"))
