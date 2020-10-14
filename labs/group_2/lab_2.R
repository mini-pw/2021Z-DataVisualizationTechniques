library(ggplot2)
library(PogromcyDanych)

data("serialeIMDB")
head(serialeIMDB)


# ggplot(), aes()


# geom_point()


# color

# size


# geom_line()


# geom_bar()

# color vs fill


# geom_histogram()




# Zadanie 1
# Narysować histogram punktów z matematyki w 2013 roku

data("maturaExam")
head(maturaExam)
mat2013 <- maturaExam %>% filter(przedmiot == "matematyka", rok == 2013)

ggplot(mat2013, aes(x = punkty)) + 
  geom_histogram(binwidth = 1)



# Zadanie 2
#Narysować wykres średniej liczby punktów w zaleności od roku i przemdiotu.


data("maturaExam")
head(maturaExam)

maturaExam %>% 
  group_by(rok,przedmiot) %>% 
  summarise(srednia = mean(punkty)) %>%
  ggplot(aes(x = as.numeric(as.character(rok)), y = srednia, color = przedmiot)) +
  geom_smooth() + 
  geom_point(size = 2)

# Zadanie 3
# Narysować zależność prebiegu od roku produkcji. Ilu różnych wykresów da się użyć do tego celu?

data("auta2012")
head(auta2012)


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

# Zadanie 4
# Narysować zależność ceny od Marki. Ile róznych wykresów da się narysować?

data("auta2012")
head(auta2012)

