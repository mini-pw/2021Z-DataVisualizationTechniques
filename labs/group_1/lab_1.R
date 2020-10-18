# install.packages("dplyr")
# install.packages("PogromcyDanych")

library(dplyr)
library(PogromcyDanych)

data("serialeIMDB")
head(serialeIMDB)


# select()

select(serialeIMDB, serial)
select(serialeIMDB, serial, sezon)
head(select(serialeIMDB, -id) )


# mutate()
head(mutate(serialeIMDB, glosow2 = glosow / 1000))
mutate(serialeIMDB, glosow2 = glosow / 1000) %>%
  head()
serialeIMDB %>%
  mutate(glosow2 = glosow / 1000) %>%
  head()

# filter()
serialeIMDB %>% 
  filter(serial == "Game of Thrones", ocena >= 9.0)
serialeIMDB %>%
  filter(serial == "Game of Thrones") %>%
  filter(ocena >= 9.0)

# arrange()
serialeIMDB %>% 
  filter(serial == "Game of Thrones", ocena >= 9.0) %>%
  arrange(-ocena)



library(tidyr)
data("imiona_warszawa")
head(imiona_warszawa)

# Nie uzywac gather i spread

# pivot_wider
imiona_szerokie <- imiona_warszawa %>%
  pivot_wider(names_from = "miesiac", values_from = liczba)

# pivot_longer
imiona_szerokie %>%
  pivot_longer(4:ncol(imiona_szerokie), names_to = "miesiac")


# Zadanie 0 
# Obejrzec: https://www.youtube.com/watch?v=LRU5TxFD394&feature=youtu.be&ab_channel=StatisticsGlobe

# Zadanie 1
# Wykonać zadanie z biblioteki proton
library(proton)






