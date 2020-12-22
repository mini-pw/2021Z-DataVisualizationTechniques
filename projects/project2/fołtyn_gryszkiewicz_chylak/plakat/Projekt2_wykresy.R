
library(readxl)
library(dplyr)
library(ggplot2)
wojewodztwa = c("dolnolaskie", "kujawsko-pomorskie", "lubelskie", "lubuskie", "lodzkie", "malopolskie", "mazowieckie",
                "opolskie", "podkarpackie", "podlaskie", "pomorskie", "slaskie", "swietokrzyskie", "warminsko-mazurskie",
                "wielkopolskie", "zachodniopomorskie")
sprzedaz <- read.csv("sprzedaz1.csv")
zakazenia <- read.csv("zakazenia.csv")
lekarstwa <- sprzedaz %>% filter(Rodzaje.działalności == "farmaceutyki, kosmetyki, sprzęt ortopedyczny" & (Nazwa == 'LUBUSKIE' | Nazwa == 'POLSKA' | Nazwa == "ŚLĄSKIE"))
paliwo <- sprzedaz %>% filter(Rodzaje.działalności == "paliwa stałe, ciekłe i gazowe" & (Nazwa == 'LUBUSKIE' | Nazwa == 'POLSKA' | Nazwa == "ŚLĄSKIE"))
jedzenie <- sprzedaz %>% filter(Rodzaje.działalności == "żywność, napoje i wyroby tytoniowe" & (Nazwa == 'LUBUSKIE' | Nazwa == 'POLSKA' | Nazwa == "ŚLĄSKIE"))



 lekarstwa$Wartosc <- as.numeric(lekarstwa$Wartosc)
lekarstwa$Wartosc = lekarstwa$Wartosc - 100
lekarstwa$Wartosc = lekarstwa$Wartosc/100
lekarstwa$Miesiące <- factor(lekarstwa$Miesiące, levels = lekarstwa$Miesiące[1:10])
paliwo$Wartosc <- as.numeric(paliwo$Wartosc)
paliwo$Wartosc = paliwo$Wartosc - 100
paliwo$Wartosc = paliwo$Wartosc/100
paliwo$Miesiące <- factor(paliwo$Miesiące, levels = paliwo$Miesiące[1:10])
jedzenie$Wartosc <- as.numeric(jedzenie$Wartosc)
jedzenie$Wartosc = jedzenie$Wartosc - 100
jedzenie$Wartosc = jedzenie$Wartosc/100
jedzenie$Miesiące <- factor(jedzenie$Miesiące, levels = jedzenie$Miesiące[1:10])
jedzenie$Miesiące
zakazenia$wojewodztwa <- factor(zakazenia$wojewodztwa, levels = zakazenia$wojewodztwa[16:1])
#Wykres o jedzeniu
ggplot(data = jedzenie, aes(y = Wartosc, x = Miesiące, group = Nazwa, color = Nazwa)) + scale_color_manual(values = c("#fb6107", "#f3de2c", "#7cb518")) +
  scale_y_continuous(limits = c(-0.8,0.25), labels = scales::percent) + geom_line(size = 1.6) + theme_bw() + 
  geom_hline(yintercept = 0, size = 1, linetype = "dashed") + 
  theme(legend.position = "bottom", legend.background = element_rect(fill = "#f4a261"), 
        legend.title = element_blank(),
        plot.background = element_rect(fill = "#f4a261"),  
        title = element_text(size = 19), axis.text.x = element_text(size = 13),
        axis.text.y = element_text(size = 13)) +
  ggtitle("Sprzedaż jedzenia względem roku 2019") + labs(x = element_blank(), y = element_blank()) +
   scale_x_discrete(breaks=jedzenie$Miesiące[1:10],
                       labels=c("sty", "lut", "marz", "kwi", "maj", "cze", "lip", "sie", "wrz", "paź"), expand = c(0,.05))

#Wykres o paliwie
ggplot(data = paliwo, aes(y = Wartosc, x = Miesiące, group = Nazwa, color = Nazwa)) + scale_color_manual(values = c("#fb6107", "#f3de2c", "#7cb518")) +
  scale_y_continuous(limits = c(-0.8,0.25), labels = scales::percent) + geom_line(size = 1.6) + theme_bw() + 
  geom_hline(yintercept = 0, size = 1, linetype = "dashed") + 
  theme(legend.position = "bottom", legend.background = element_rect(fill = "#e9c46a"), 
        legend.title = element_blank(),
        plot.background = element_rect(fill = "#e9c46a"),  
        title = element_text(size = 19), axis.text.x = element_text(size = 13),
        axis.text.y = element_text(size = 13)) +
  ggtitle("Sprzedaż paliwa względem roku 2019") + labs(x = element_blank(), y = element_blank()) +
  scale_x_discrete(breaks=paliwo$Miesiące[1:10],
                   labels=c("sty", "lut", "marz", "kwi", "maj", "cze", "lip", "sie", "wrz", "paź"), expand = c(0,.05))


#Wykres o lekarstwach
ggplot(data = lekarstwa, aes(y = Wartosc, x = Miesiące, group = Nazwa, color = Nazwa)) + scale_color_manual(values = c("#fb6107", "#f3de2c", "#7cb518")) +
  scale_y_continuous(limits = c(-0.8,0.25), labels = scales::percent) + geom_line(size = 1.6) + theme_bw() + 
  geom_hline(yintercept = 0, size = 1, linetype = "dashed") + 
  theme(legend.position = "bottom", legend.background = element_rect(fill = "#e76f51"), 
        legend.title = element_blank(),
        plot.background = element_rect(fill = "#e76f51"),  
        title = element_text(size = 19), axis.text.x = element_text(size = 13),
        axis.text.y = element_text(size = 13)) +
  ggtitle("Sprzedaż leków względem roku 2019") + labs(x = element_blank(), y = element_blank()) +
  scale_x_discrete(breaks=lekarstwa$Miesiące[1:10],
                   labels=c("sty", "lut", "marz", "kwi", "maj", "cze", "lip", "sie", "wrz", "paź"), expand = c(0,.05))


#Wykres województwa
ggplot(data = zakazenia, aes(y = zakazenia_suma, x = wojewodztwa)) + geom_bar(stat = "identity", fill = "#e76f51") + 
  theme_bw() + coord_flip() + ggtitle(c("Liczba zakażeń w poszczególnych\n województwach")) +
  theme(plot.background = element_rect(fill = "#2a9d8f"),  
  title = element_text(size = 16), axis.text.x = element_text(size = 13),
  axis.text.y = element_text(size = 13)) + labs(x = element_blank(), y = element_blank()) + scale_y_continuous(labels = scales::comma)

# Wszystkie dane pochodza z https://bdl.stat.gov.pl/BDL/start
# oraz z https://docs.google.com/spreadsheets/d/1ierEhD6gcq51HAm433knjnVwey4ZE5DCnu1bW7PRG3E/htmlview#
# by Michał Rogalski