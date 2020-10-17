# install.packages("dplyr")
# install.packages("PogromcyDanych")

library(dplyr)
library(PogromcyDanych)

data("serialeIMDB")
head(serialeIMDB)


# select()
select(serialeIMDB, serial)

head(select(serialeIMDB, serial, nazwa))
serialeIMDB %>%
  select(serial, nazwa) %>%
  head()
serialeIMDB %>% 
  select(-id) %>%
  head()


# mutate()
serialeIMDB %>%
  mutate(suma_glosow = ocena * glosow) %>%
  head()


# filter()
serialeIMDB %>%
  filter(serial == "Sherlock")

serialeIMDB %>%
  filter(serial == "Sherlock") %>%
  filter(ocena >= 9.0)

serialeIMDB %>% 
  filter(serial == "Sherlock", ocena >= 9.0)

# arrange()
serialeIMDB %>% 
  filter(serial == "Sherlock", ocena >= 9.0) %>%
  arrange(desc(ocena))

serialeIMDB %>% 
  filter(serial == "Sherlock", ocena >= 9.0) %>%
  arrange(-ocena)



library(tidyr)
data("imiona_warszawa")
head(imiona_warszawa, n = 15)

# pivot_wider
imiona_szerokie <- imiona_warszawa %>%
  pivot_wider(names_from = miesiac, values_from = liczba)

# pivot_longer
imiona_szerokie %>%
  pivot_longer(4:ncol(imiona_szerokie), "miesiac")

# spread(), gather() - "dprecated" 



# Zadanie 0 
# Obejrzec: https://www.youtube.com/watch?v=LRU5TxFD394&feature=youtu.be&ab_channel=StatisticsGlobe

# Zadanie 1
# Wykonać zadanie z biblioteki proton
library(proton)






