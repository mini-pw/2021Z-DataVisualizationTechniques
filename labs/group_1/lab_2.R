library(ggplot2)
library(PogromcyDanych)

data("serialeIMDB")
head(serialeIMDB)

bb <- serialeIMDB %>%
  filter(serial == "Breaking Bad", sezon == 1)

# ggplot(), aes()
ggplot(bb, aes(x = odcinek, y = ocena))

# geom_point()
ggplot(bb, aes(x = odcinek, y = ocena)) +
  geom_point()

# color
ggplot(bb, aes(x = odcinek, y = ocena, color = glosow)) +
  geom_point(size = 8)

ggplot(bb, aes(x = odcinek, y = ocena)) +
  geom_point(aes(color = glosow), size = 8)

ggplot(bb, aes(x = odcinek, y = ocena, color = odcinek)) +
  geom_point(size = 8)

ggplot(bb, aes(x = odcinek, y = ocena, color = as.numeric(odcinek))) +
  geom_point(size = 8)

as.numeric(as.character(bb$odcinek))
droplevels(bb$odcinek)
odcinki <-  droplevels(bb$odcinek)
bb$odcinek <- factor(odcinki, levels = c(2, 3, 4, 5, 6, 7, 1))

ggplot(bb, aes(x = odcinek, y = ocena, color = odcinek)) +
  geom_point(size = 8)


# size
ggplot(bb, aes(x = odcinek, y = ocena)) +
  geom_point(size = 5)

ggplot(bb, aes(x = odcinek, y = ocena, size = ocena)) +
  geom_point()

ggplot(bb, aes(x = odcinek, y = ocena)) +
  geom_point(aes(size = ocena))

# shape
ggplot(bb, aes(x = odcinek, y = ocena, shape = odcinek)) +
  geom_point(size = 10)

# geom_line()
ggplot(bb, aes(x = as.numeric(as.character(odcinek)), y = ocena)) +
  geom_line()

ggplot(bb, aes(x = as.numeric(as.character(odcinek)), y = ocena)) +
  geom_smooth()

ggplot(bb, aes(x = as.numeric(as.character(odcinek)), y = ocena)) +
  geom_line(color = "green", size = 3) +
  geom_point(size = 5)

ggplot(bb, aes(x = as.numeric(as.character(odcinek)), y = ocena)) +
  geom_point(size = 5) +
  geom_line(color = "green", size = 3) +
  geom_smooth(se = FALSE)

# geom_bar()
ggplot(bb, aes(x = factor(odcinek, levels = 1:7), y = glosow)) + 
  geom_bar(stat = "identity")

# tutaj zlicza w ilu wierszach wystąpiła wartość, każdy odcinek raz
ggplot(bb, aes(x = factor(odcinek, levels = 1:7))) + 
  geom_bar()

# geom_col()
ggplot(bb, aes(x = factor(odcinek, levels = 1:7), y = glosow)) + 
  geom_col()

# geom_boxplot()
bb_all <- serialeIMDB %>%
  filter(serial == "Breaking Bad")

ggplot(bb_all, aes(x = sezon, y = glosow, colour = sezon)) +
  geom_boxplot()

ggplot(bb_all, aes(x = sezon, y = glosow, fill = sezon)) +
  geom_boxplot() +
  ylim(c(4500, 20000))

ggplot(bb_all, aes(x = sezon, y = glosow, fill = sezon)) +
  geom_boxplot() +
  scale_y_log10()


# geom_violin()
ggplot(bb_all, aes(x=sezon, y = ocena)) +
  geom_violin()


# geom_histogram()
data("maturaExam")
head(maturaExam)

matura <- maturaExam %>%
  filter(przedmiot == "j. polski", rok == 2013)
ggplot(matura, aes(x = punkty)) +
  geom_histogram(binwidth=1)




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

