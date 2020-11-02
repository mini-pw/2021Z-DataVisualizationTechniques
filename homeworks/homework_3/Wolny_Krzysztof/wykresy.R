#                       WYKRESY
library(ggplot2)
library(dplyr)
library(patchwork)

#########################################################################3
# Wykres slupkowy i kolowy przy w miare rownych danych. 
# Dane to 15, 18, 22, 25, 30

data1 = data.frame(nazwa = c("makowiec","sernik", "sękacz", "tiramisu", "brownie"), 
                   ilosc = c(15, 17, 20, 22, 26))
data1$nazwa <- factor(data1$nazwa, levels = data1$nazwa)

## Slupkowy
p11 <- ggplot(data1, aes(x = nazwa, y = ilosc, fill=nazwa)) + 
  geom_bar(stat = "identity") +  
  geom_text(aes(label=paste(ilosc, "%", sep = "")), vjust=-0.5, size = 3) + 
  scale_fill_manual(values = c('#8dd3c7','#ffffb3','#bebada','#fb8072','#994d00')) + 
  xlab("") + 
  ylab("Ilość w %") +   
  theme_light() + 
  theme(panel.grid.major.x = element_blank(),
        panel.border = element_blank(),  
        axis.line = element_line(colour = "grey"), 
        panel.grid.major.y = element_line(colour = "grey"), 
        panel.grid.minor.y = element_line(colour = "grey"), 
        plot.title = element_text(size = 18), 
        legend.position = "none") + 
  scale_y_continuous(limits = c(0, 30), 
                   breaks = seq(0, 35, 10), 
                   labels = paste(seq(0, 35, 10), "%", sep = "")) 
  

## Kolowy
dataPie1 <- data1%>%
  arrange(desc(nazwa)) %>%
  mutate(lab.ypos = cumsum(ilosc) - 0.5*ilosc)

p12 <- ggplot(dataPie1, aes(x = "nazwa", y = ilosc, fill=nazwa)) + 
  geom_bar(stat = "identity", width=1, color="white") + 
  coord_polar("y", start=0) + 
  theme_light() + 
  theme(panel.grid.major.x = element_blank()) + 
  scale_fill_manual(values = c('#8dd3c7','#ffffb3','#bebada','#fb8072','#994d00')) + 
  theme_void() + 
  geom_text(aes(y = lab.ypos, label = paste(ilosc, "%", sep = ""))) + 
  labs( fill = "Ilość w %: ") + 
  theme(plot.title = element_text(size = 18, hjust = 0.5)) 

p11 + p12 + 
  labs(title = "Procentowa sprzedaż ciast") + 
  theme(plot.title = element_text(size = 18, hjust = 1.5))


########################################################################3

# Wykres slupkowy i kolowy przy duzych roznicach wartosci. 
# Dane to 8, 15, 20, 57


data2 <- data.frame(nazwa = c("D","C", "B", "A"), 
                    ilosc = c(7, 13, 24, 56))
data2$nazwa <- factor(data2$nazwa, levels = data2$nazwa)


## Slupkowy
p21 <- ggplot(data2, aes(x = nazwa, y = ilosc, fill=nazwa)) + 
  geom_bar(stat = "identity") +  
  geom_text(aes(label=paste(ilosc, "%", sep = "")), vjust=-0.5, size = 3) + 
  scale_fill_manual(values = c('#d73027', '#fc8d59', '#fee08b','#91cf60')) + 
  xlab("") + 
  ylab("Ilość w %") +   
  theme_light() + 
  theme(panel.grid.major.x = element_blank(),
        panel.border = element_blank(),  
        axis.line = element_line(colour = "grey"), 
        panel.grid.major.y = element_line(colour = "grey"), 
        panel.grid.minor.y = element_blank(), 
        legend.position = "none") + 
  scale_y_continuous(limits = c(0, 60), 
                     breaks = seq(0, 60, 10), 
                     labels = paste(seq(0, 60, 10), "%", sep = "")) 

## Kolowy
dataPie2 <- data2%>%
  arrange(desc(nazwa)) %>%
  mutate(lab.ypos = cumsum(ilosc) - 0.5*ilosc)

p22 <- ggplot(dataPie2, aes(x = "nazwa", y = ilosc, fill=nazwa)) + 
  geom_bar(stat = "identity", width=1, color="white") + 
  coord_polar("y", start=0) + 
  theme_light() + 
  theme(panel.grid.major.x = element_blank()) + 
  scale_fill_manual(values =c('#d73027', '#fc8d59', '#fee08b','#91cf60')) + 
  theme_void() + 
  geom_text(aes(y = lab.ypos, label = paste(ilosc, "%", sep = ""))) + 
  labs(fill = "Ilość w %: ") + 
  guides(fill = guide_legend(reverse=TRUE))

p21 + p22 + 
  labs(title = "Wyniki sprawdzianu") + 
  theme(plot.title = element_text(size = 18, vjust = 3, hjust = 0.5))

##################################################################

# Wykres slupkowy i kolowy przy 2 danych (kobiety, mezczyzni)
# Dane: 65, 35

data3 <- data.frame(nazwa = c("kobiety","mezczyzni"), 
                    ilosc = c(65, 35))

## Slupkowy
p31 <- ggplot(data3, aes(x = nazwa, y = ilosc, fill=nazwa)) + 
  geom_bar(stat = "identity") +  
  geom_text(aes(label=paste(ilosc, "%", sep = "")), vjust=-0.5, size = 3) + 
  scale_fill_manual(values = c('#fc8d59','#91bfdb')) + 
  xlab("") + 
  ylab("Ilość w %") +   
  theme_light() + 
  theme(panel.grid.major.x = element_blank(),
        panel.border = element_blank(),  
        axis.line = element_line(colour = "grey"), 
        panel.grid.major.y = element_line(colour = "grey"), 
        panel.grid.minor.y = element_blank(), 
        legend.position = "none") + 
  scale_y_continuous(limits = c(0, 70), 
                     breaks = seq(0, 70, 10), 
                     labels = paste(seq(0, 70, 10), "%", sep = "")) 

## Kolowy
dataPie3 <- data3%>%
  arrange(desc(nazwa)) %>%
  mutate(lab.ypos = cumsum(ilosc) - 0.5*ilosc)

p32 <- ggplot(dataPie3, aes(x = "nazwa", y = ilosc, fill=nazwa)) + 
  geom_bar(stat = "identity", width=1, color="white") + 
  coord_polar("y", start=0) + 
  theme_light() + 
  theme(panel.grid.major.x = element_blank()) + 
  scale_fill_manual(values = c('#fc8d59','#91bfdb')) + 
  theme_void() + 
  geom_text(aes(y = lab.ypos, label = paste(ilosc, "%", sep = ""))) + 
  labs(fill = "Ilość w %: ") + 

p31 + p32 + 
  labs(title = "Udział w koncercie z podziałem na płeć") + 
  theme(plot.title = element_text(size = 18, hjust = 0.8))

#####################################################
#                   RAPORT
# 1. Dane są podobnej wielkości
dataRap1 <- data.frame(nazwa = c("wykres słupkowy","wykres kołowy"),
                       ilosc = c(93.3, 6.7))
dataPieRap1 <- dataRap1%>%
  arrange(desc(nazwa)) %>%
  mutate(lab.ypos = cumsum(ilosc) - 0.5*ilosc)

ggplot(dataPieRap1, aes(x = "nazwa", y = ilosc, fill=nazwa)) +
  labs(title = "Dane podobnej wielkości") + 
  geom_bar(stat = "identity", width=1, color="white") + 
  coord_polar("y", start=0) + 
  theme_light() + 
  theme(panel.grid.major.x = element_blank()) + 
  scale_fill_manual(values = c('#1a75ff','#e60000')) + 
  theme_void() + 
  geom_text(aes(y = lab.ypos, label = paste(ilosc, "%", sep = ""))) + 
  labs(fill = "") + 
  theme(plot.title = element_text(hjust = 0.5))


############################################################333
# 2. Dane mają dużą różnicę wielkości
dataRap2 <- data.frame(nazwa = c("wykres słupkowy","wykres kołowy"),
                       ilosc = c(46.7, 53.3))
dataPieRap2 <- dataRap2%>%
  arrange(desc(nazwa)) %>%
  mutate(lab.ypos = cumsum(ilosc) - 0.5*ilosc)

ggplot(dataPieRap2, aes(x = "nazwa", y = ilosc, fill=nazwa)) +
  labs(title = "Dane mają dużą różnicę wielkości") + 
  geom_bar(stat = "identity", width=1, color="white") + 
  coord_polar("y", start=0) + 
  theme_light() + 
  theme(panel.grid.major.x = element_blank()) + 
  scale_fill_manual(values = c('#1a75ff','#e60000')) + 
  theme_void() + 
  geom_text(aes(y = lab.ypos, label = paste(ilosc, "%", sep = ""))) + 
  labs(fill = "") + 
  theme(plot.title = element_text(size = 18, hjust = 0.5))

######################################################################
# 3. Dane mają dwie wartości
dataRap3 <- data.frame(nazwa = c("wykres słupkowy","wykres kołowy"),
                       ilosc = c(33.3, 66.7))
dataPieRap3 <- dataRap3%>%
  arrange(desc(nazwa)) %>%
  mutate(lab.ypos = cumsum(ilosc) - 0.5*ilosc)

ggplot(dataPieRap3, aes(x = "nazwa", y = ilosc, fill=nazwa)) +
  labs(title = " Dane mają dwie wartości") + 
  geom_bar(stat = "identity", width=1, color="white") + 
  coord_polar("y", start=0) + 
  theme_light() + 
  theme(panel.grid.major.x = element_blank()) + 
  scale_fill_manual(values = c('#1a75ff','#e60000')) + 
  theme_void() + 
  geom_text(aes(y = lab.ypos, label = paste(ilosc, "%", sep = ""))) + 
  labs(fill = "") + 
  theme(plot.title = element_text(size = 18, hjust = 0.5))



