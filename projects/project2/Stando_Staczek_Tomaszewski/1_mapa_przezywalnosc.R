library(rgdal)
library(cartography)

# Źródło danych do granic:
# https://gis-support.pl/baza-wiedzy-2/dane-do-pobrania/granice-administracyjne/
# Źródłem danych jest: Państwowy Rejestr Granic
# Zbiór udostępniony "bez opłat"

# Dane o przeżywalności obliczone na podstawie danych zebranych przez Michała Rogalskiego

my_spdf1 <- readOGR( dsn= "." , layer="Województwa", verbose=FALSE) 
my_spdf1@data$dane <- c(158.0, 216.9, 142.9, 128.7,
                        190.9, 109.5, 185.3, 155.0,
                        236.6, 207.3, 154.5, 168.0,
                        127.4, 157.6, 206.4, 169.8)/100

cols <- carto.pal(pal1 = "blue.pal",n1 = 4)

breaks <- c(1, 1.4, 1.8, 2.2, 2.6)

choroLayer(spdf = my_spdf1, 
           var = "dane",
           col=cols,
           breaks = breaks,
           legend.title.txt = "Death Rate\n(in percents)",
           legend.values.rnd = 1,
           border = "black")
title("Death Rate")

display.carto.all()
