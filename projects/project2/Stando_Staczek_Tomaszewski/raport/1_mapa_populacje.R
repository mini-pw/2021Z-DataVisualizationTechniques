library(rgdal)
library(cartography)

# Źródło danych do granic:
# https://gis-support.pl/baza-wiedzy-2/dane-do-pobrania/granice-administracyjne/
# Źródłem danych jest: Państwowy Rejestr Granic
# Zbiór udostępniony "bez opłat"

# Dane o populacji w województwach pochodzą ze GUSu 

my_spdf1 <- readOGR( dsn= "." , layer="Województwa", verbose=FALSE) 
my_spdf1@data$dane <- c(4517635, 982626, 3498733, 1696193, 
                        1233961, 2072373, 1178353, 2900163, 
                        2127164, 3410901, 2343928, 1422737, 
                        2454779, 5423168, 2108270, 1011592)/1000000

cols <- carto.pal(pal1 = "blue.pal",n1 = 4)

breaks <- c(0, 1.5, 3, 4.5, 6)

choroLayer(spdf = my_spdf1, 
           var = "dane",
           col=cols,
           breaks = breaks,
           legend.title.txt = "Population\n(in mln)",
           legend.values.rnd = 1,
           border = "black")
title("Population")

