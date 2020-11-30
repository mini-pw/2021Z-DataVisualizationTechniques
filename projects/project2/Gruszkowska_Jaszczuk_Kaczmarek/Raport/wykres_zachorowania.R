library(dplyr)
library(ggplot2)

nowe_przypadki <- read.table("Dane.csv",header=TRUE, sep=";")

nowe <-data.frame(nowe_przypadki$Data, nowe_przypadki$Nowe.przypadki)
colnames(nowe) <- c("data", "ilosc")

ggplot(nowe, aes(x=as.Date(data), y=ilosc))+
  stat_smooth(se=FALSE, n=150, span=0.1 )+
  ggtitle("Nowe przypadki zachorowañ w Polsce")+
  labs(y="Iloœæ nowych zachorowañ", x="Kolejne dni epidemii")+
  theme_light()+
  theme(axis.title.x = element_text(),axis.title.y = element_text(), legend.position = "",plot.title = element_text(hjust = 0.5))

  scale_color_hue(labels=c("7-dniowa œrednia", "Przybli¿enie faktycznych wartoœci"), title)+
  guides(color=guide_legend("Wykresy"))+
  theme(axis.title.x = element_text(),axis.title.y = element_text(), legend.position = "bottom",plot.title = element_text(hjust = 0.5))+
  labs(y="Iloœæ nowych zachorowañ", x="Kolejne dni epidemii")

  
  
przypadki_nowe_density<-data.frame(rep(nowe_przypadki$Data, nowe_przypadki$Nowe.przypadki))
jedynki<-rep(1, nrow(przypadki_nowe_density))
przypadki_nowe_density<-data.frame(przypadki_nowe_density, jedynki)  
colnames(przypadki_nowe_density) <- c("data", "ilosc")
  
daty<-c("2020-02-05", "2020-02-06","2020-02-06","2020-02-06", "2020-02-07","2020-02-07")
ilosc<-c(1,1,1,1,1,1)
test<-data.frame(daty, ilosc)
test
datyy<-c("2020-02-05", "2020-02-06", "2020-02-07")
ilosci<-c(3,4,5)
test2<-data.frame(datyy, ilosci)
str(test2)
daty2<-rep(datyy, ilosc)
daty2

ggplot(test, aes(as.Date(daty),fill="blue", color="green"))+
  geom_density(alpha=0.1)
test
head(przypadki_nowe_density)

ggplot(przypadki_nowe_density, aes(as.Date(data),fill="red", color="red"))+
  geom_density(alpha=0.1)+
  labs(title="Nowe przypadki zachorowañ w Polsce",x="Kolejne dni epidemii", y = "Iloœæ nowych zachorowañ")+
  theme_light()+
  theme(axis.title.x = element_text(),axis.title.y = element_text(), legend.position = "",plot.title = element_text(hjust = 0.5))
