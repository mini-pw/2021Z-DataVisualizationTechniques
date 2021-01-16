library(dplyr)
library(ggplot2)
library(svglite)

#distinct(scatter_dane["Wojewodztwo"]) # - do zobaczenia nazw wojewodztw

scatter_dane = read.csv('dane/scatter_dane.csv', fileEncoding = "UTF-8")

scatter_dane["kolor"] = ifelse(scatter_dane["Wojewodztwo"] == "ŚLĄSKIE", "śląskie", 
                               ifelse(scatter_dane["Wojewodztwo"] == "MAZOWIECKIE", "mazowieckie", 
                                      ifelse(scatter_dane["Wojewodztwo"] == "ŚWIĘTOKRZYSKIE", "świętokrzyskie", "other")))

scatter_dane$kolor<-factor(scatter_dane$kolor, levels=c("mazowieckie","śląskie","świętokrzyskie","other"))
scatter_dane$Nazwa_eng <- gsub("Powiat", "County", scatter_dane$Nazwa)

scatter_dane %>%
  ggplot(aes(x=Gestosc_zaludnienia, y=Procent_chorych, label = Nazwa_eng, color = kolor)) +
  #geom_point(color = 'orangered3') +# stat_smooth(method = 'lm') +
  geom_point(size = 3) +
  #scale_color_identity() +
  scale_colour_manual(name = 'Voivodeship:', 
                      values =c('śląskie'='red', 'mazowieckie'='green3', 'świętokrzyskie'='blue', 'other'='#64646470')) +
  scale_x_continuous(trans = 'log10', limits = c(20, 5000)) + #annotation_logticks() +
  geom_label(data = scatter_dane %>%
               filter(Gestosc_zaludnienia %in% tail(sort(Gestosc_zaludnienia), 2) | # slabo dziala, bo sie log skala rozjezdza
                        Procent_chorych %in% tail(sort(Procent_chorych), 4)),
             nudge_y = -1.9, alpha = 0.4, size = 4.5) + # trzeba dostosowywac tylko w y bo log skala
  xlab('Population density (number of people per km^2)') + ylab('Number of cases per 1000  people') +
  theme_bw(base_size = 20) + theme(legend.position=c(0.9, 0.82))

#ggsave(filename = 'wykresy/Scatterplot_powiatow.svg', width = 13, height = 6, dpi = 100)
ggsave(filename = 'wykresy/Scatterplot_powiatow.png', width = 13, height = 6, dpi = 100)