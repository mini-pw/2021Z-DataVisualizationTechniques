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
mat2013 <- maturaExam %>% filter(przedmiot == "matematyka", rok == 2013)

ggplot(mat2013, aes(x = punkty)) + 
  geom_histogram(binwidth = 1)


# Zadanie 2
# Narysować wykres średniej liczby punktów w zaleności od roku i przedmiotu.

data("maturaExam")
head(maturaExam)

<<<<<<< HEAD
maturaExam %>% 
  group_by(rok,przedmiot) %>% 
  summarise(srednia = mean(punkty)) %>%
  ggplot(aes(x = as.numeric(as.character(rok)), y = srednia, color = przedmiot)) +
  geom_smooth() + 
  geom_point(size = 2)
=======
>>>>>>> 07cea6cbddd1c4be0fdb709aff85e26519a0b426

# Zadanie 3
# Narysować zależność prebiegu od roku produkcji. Ilu różnych wykresów da się użyć do tego celu?

data("auta2012")
head(auta2012)


<<<<<<< HEAD
auta2012$Rok.produkcji <- factor(auta2012$Rok.produkcji)
auta2012 %>%
  group_by(Rok.produkcji)%>%
  summarise(sredni_przebieg = median(Przebieg.w.km, na.rm = TRUE)) %>%
  ggplot(aes(y = sredni_przebieg, x = Rok.produkcji))+
  geom_point()+
  ylim(c(0,300000))

data("auta2012")
auta2012 %>%
  ggplot(aes(y = Przebieg.w.km, x = Rok.produkcji))+
  geom_violin()+
  ylim(c(0,50000))

auta2012 %>%
  ggplot(aes(y = Przebieg.w.km, x = Rok.produkcji))+
  geom_bar(stat = "identity") +
  ylim(c(0,50000))

  
auta2012 %>%
  ggplot(aes(y = Przebieg.w.km, x = Rok.produkcji))+
  geom_jitter(size = 0.01) +
  ylim(c(0,500000))


auta2012 %>%
  filter(!is.na(Przebieg.w.km), Przebieg.w.km<2500000) %>%
  ggplot(aes(y = Przebieg.w.km, x = Rok.produkcji))+
  geom_boxplot()

auta2012 %>%
  group_by(Rok.produkcji)%>%
  summarise(sredni_przebieg = median(Przebieg.w.km, na.rm = TRUE)) %>%
  ggplot(aes(y = sredni_przebieg, x = Rok.produkcji))+
  geom_smooth()+
  geom_point()

auta2012 %>%
  group_by(Rok.produkcji)%>%
  summarise(sredni_przebieg = median(Przebieg.w.km, na.rm = TRUE)) %>%
  ggplot(aes(y = sredni_przebieg, x = Rok.produkcji))+
  geom_rug()

=======
>>>>>>> 07cea6cbddd1c4be0fdb709aff85e26519a0b426
# Zadanie 4
# Narysować zależność ceny od Marki. Ile róznych wykresów da się narysować?

data("auta2012")
head(auta2012)

