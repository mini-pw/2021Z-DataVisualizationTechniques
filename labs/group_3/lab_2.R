library(ggplot2)
library(PogromcyDanych)

data("serialeIMDB")
head(serialeIMDB)


bb <- serialeIMDB %>%
  filter(serial == "Breaking Bad", sezon == 1)
bb  
  
# ggplot(), aes()
ggplot(bb, aes(x = odcinek, y = ocena))

# geom_point()
ggplot(bb, aes(x = odcinek, y = ocena)) +
  geom_point()

# size
ggplot(bb, aes(x = odcinek, y = ocena)) +
  geom_point(size = 8)

ggplot(bb, aes(x = odcinek, y = ocena, size = ocena)) +
  geom_point()

ggplot(bb, aes(x = odcinek, y = ocena)) +
  geom_point(aes(size = ocena))

# color
ggplot(bb, aes(x = odcinek, y = ocena, color = ocena)) +
  geom_point()
# color i colour - oba dzialaja
ggplot(bb, aes(x = odcinek, y = ocena, colour = ocena)) +
  geom_point(size = 8)

# factor - inna skala kolorów
ggplot(bb, aes(x = odcinek, y = ocena, colour = odcinek)) +
  geom_point(size = 8)

ggplot(bb, aes(x = odcinek, y = ocena, colour = factor(ocena))) +
  geom_point(size = 8)

ggplot(bb, aes(x = odcinek, y = ocena, colour = as.numeric(as.character(odcinek)))) +
  geom_point(size = 8) 

as.character(bb$odcinek) # uwaga, nie te wartosci, ktore bysmy chcieli
as.numeric(as.character(bb$odcinek))

ggplot(bb, aes(x = odcinek, y = ocena, colour = factor(odcinek, levels = c(1,2,3,7,6,5,4)))) +
  geom_point(size = 8)

# geom_line()
ggplot(bb, aes(x = as.numeric(as.character(odcinek)), y = ocena)) +
  geom_line()

ggplot(bb, aes(x = as.numeric(as.character(odcinek)), y = ocena)) +
  geom_line(size = 4, color = "blue")

ggplot(bb, aes(x = as.numeric(as.character(odcinek)), y = ocena)) +
  geom_line(size = 4, color = "blue") +
  geom_point(size = 8)

ggplot(bb, aes(x = as.numeric(as.character(odcinek)), y = ocena)) +
  geom_point(size = 8) +
  geom_line(size = 4, color = "blue") 
  
# geom_bar()

ggplot(bb, aes(x = odcinek, y = glosow)) +
  geom_bar(stat="identity")

ggplot(bb, aes(x = odcinek)) +
  geom_bar()

df <- data.frame(a = c(rep("F", 4), rep("G", 3)))
ggplot(df, aes(x = a)) +
  geom_bar()

ggplot(bb, aes(x = odcinek, y = glosow)) +
  geom_col()

# geom_boxplot()
bb_all <- serialeIMDB %>%
  filter(serial == "Breaking Bad")

ggplot(bb_all, aes(x = sezon, y = glosow, color = sezon)) +
  geom_boxplot()
ggplot(bb_all, aes(x = sezon, y = glosow, fill = sezon)) +
  geom_boxplot()

ggplot(bb_all, aes(x = sezon, y = glosow, fill = sezon)) +
  geom_boxplot() +
  ylim(c(4500, 20000))

ggplot(bb_all, aes(x = sezon, y = glosow, fill = sezon)) +
  geom_boxplot() +
  scale_y_log10()  

# geom_violin()
ggplot(bb_all, aes(x = sezon, y = ocena)) +
  geom_violin()

# geom_histogram()

data("maturaExam")
head(maturaExam)

matura <- maturaExam %>%
  filter(przedmiot == "j. polski", rok == 2013)
matura

ggplot(matura, aes(x = punkty)) +
  geom_histogram(binwidth = 1)


# theme()
ggplot(bb, aes(x = odcinek, y = ocena, colour = as.numeric(as.character(odcinek)))) +
  geom_point(size = 8) +
  labs(color = "Legenda")

# Zadanie 1
# Narysować histogram punktów z matematyki w 2013 roku

data("maturaExam")
head(maturaExam)


# Zadanie 2
# Narysować wykres średniej liczby punktów w zaleności od roku i przedmiotu.

data("maturaExam")
head(maturaExam)


# Zadanie 3
# Narysować zależność prebiegu od roku produkcji. Ilu różnych wykresów da się użyć do tego celu?

data("auta2012")
head(auta2012)


# Zadanie 4
# Narysować zależność ceny od Marki. Ile róznych wykresów da się narysować?

data("auta2012")
head(auta2012)

