library(dplyr)
library(ggplot2)


scatter_dane = read.csv('dane/scatter_dane.csv', fileEncoding = "UTF-8")

scatter_dane %>%
  #filter(Gęstość_zaludnienia < 250 & procent_chorych < 0.03) %>% # - opcjonalne zeby wiecej pokazac
  ggplot(aes(x=Gestosc_zaludnienia, y=Procent_chorych, label = Nazwa)) +
  geom_point(color = 'orangered3') +# stat_smooth(method = 'lm') +
  scale_x_continuous(trans = 'log10') + annotation_logticks() +
  geom_label(data = scatter_dane %>%
               filter(Gestosc_zaludnienia %in% tail(sort(Gestosc_zaludnienia), 2) | # slabo dziala, bo sie log skala rozjezdza
                        Procent_chorych %in% tail(sort(Procent_chorych), 3)),
             nudge_y = -0.001, alpha = 0.4, size = 3) + # trzeba dostosowywac tylko w y bo log skala
  xlab('Gęstość zaludnienia') + ylab('Procent chorych') +
  theme_bw

ggsave(filename = 'wykresy/Scatterplot_powiatow.png', width = 11, height = 8)