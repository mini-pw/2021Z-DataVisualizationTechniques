library(ggplot2)
library(PogromcyDanych)

data("serialeIMDB")
head(serialeIMDB)

bb <- serialeIMDB %>%
  filter(serial == "Breaking Bad", sezon == 1)

# ggplot(), aes()
ggplot(data = bb, aes(x = odcinek, y = ocena))

# geom_point()
ggplot(data = bb, aes(x = odcinek, y = ocena)) +
  geom_point(size = 8)

# size
ggplot(data = bb, aes(x = odcinek, y = ocena, size = ocena)) +
  geom_point()

ggplot(data = bb, aes(x = odcinek, y = ocena)) +
  geom_point(aes(size = ocena))

# color
ggplot(data = bb, aes(x = odcinek, y = ocena, size = ocena, color = ocena)) +
  geom_point()

ggplot(data = bb, aes(x = odcinek, y = ocena, color = odcinek)) +
  geom_point(size = 8)
ggplot(data = bb, aes(x = odcinek, y = ocena, color = ocena)) +
  geom_point(size = 8)
ggplot(data = bb, aes(x = odcinek, y = ocena, color = factor(ocena))) +
  geom_point(size = 8)
ggplot(data = bb, aes(x = odcinek, y = ocena, color = as.numeric(as.character(odcinek)))) +
  geom_point(size = 8)

bb$odcinek
as.numeric(bb$odcinek) # dziwne wartości wynikające z poziomów factora
as.numeric(as.character(bb$odcinek)) # odpowiednie wartości

ggplot(data = bb, aes(x = odcinek, y = ocena, color = odcinek)) +
  geom_point(size = 8)

# jak zmienic kolejnosc factora
bb$odcinek <- factor(bb$odcinek, levels = c(7,6,5,4,3,2,1))
ggplot(data = bb, aes(x = odcinek, y = ocena, color = odcinek)) +
  geom_point(size = 8)

bb$odcinek <- factor(bb$odcinek, levels = 1:7)

# shape
ggplot(data = bb, aes(x = odcinek, y = ocena, shape = odcinek)) +
  geom_point(size = 8)


# geom_line()
ggplot(data = bb, aes(x = as.numeric(as.character(odcinek)), y = ocena)) +
  geom_line()

ggplot(data = bb, aes(x = as.numeric(as.character(odcinek)), y = ocena)) +
  geom_line(size = 5, color = "green")
ggplot(data = bb, aes(x = as.numeric(as.character(odcinek)), y = ocena)) +
  geom_line(size = 5, color = "#906745")

ggplot(data = bb, aes(x = as.numeric(as.character(odcinek)), y = ocena)) +
  geom_line(size = 5, color = "#906745") +
  geom_point(size = 8)

ggplot(data = bb, aes(x = as.numeric(as.character(odcinek)), y = ocena)) +
  geom_point(size = 8) +
  geom_line(size = 5, color = "#906745") 

# geom_smooth
ggplot(bb, aes(x = as.numeric(as.character(odcinek)), y = ocena)) +
  geom_smooth()

ggplot(bb, aes(x = as.numeric(as.character(odcinek)), y = ocena)) +
  geom_smooth(se = FALSE) 

ggplot(bb, aes(x = as.numeric(as.character(odcinek)), y = ocena)) +
  geom_smooth(se = FALSE) +
  geom_line() +
  geom_point()


# geom_bar()
# wezmie wartosci z y
ggplot(bb, aes(x=odcinek, y=glosow)) +
  geom_bar(stat="identity")

# policzy wystapienia
ggplot(bb, aes(x=odcinek)) +
  geom_bar()

df <- data.frame(a = c("A", "A", "B", "B", "B"))
ggplot(df, aes(x = a)) +
  geom_bar()

# geom_col()
ggplot(bb, aes(x=odcinek, y=glosow)) +
  geom_col()

ggplot(bb, aes(x=odcinek, y=glosow)) +
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

ggplot(bb_all, aes(x = sezon, y = ocena, fill = sezon)) +
  geom_boxplot() 

# geom_violin()
ggplot(bb_all, aes(x = sezon, y = ocena)) +
  geom_violin()


# geom_histogram()

data("maturaExam")
head(maturaExam)

matura <- maturaExam %>%
  filter(rok == 2013, przedmiot == "j. polski")

ggplot(matura, aes(x = punkty)) +
  geom_histogram(binwidth = 1)


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

