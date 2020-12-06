
############# PLOTLY - interaktywne wizualizacje #################

library(plotly)
library(dplyr)
library(tidyr)

library(DALEX)
## Dane o smokach
data(dragons)
head(dragons)
# informacje o zmiennych
?dragons

# https://plotly.com/r/

#### WYKRES PUNKTOWY ####

# Podstawa tworzenia wykresow jest funkcja plot_ly()
# Mapowanie kolumn do atrybutow odbywa sie poprzez podanie nazwy poprzedzonej znakiem ~ 
# przez parametr `type` definiujemy typ wykresu, a mode formę, w jakiej pokazane będą dane.

plot_ly(data = dragons, x = ~height, y = ~weight, 
        type = "scatter", mode = "markers")
# Uwaga, wykres powinien pojawić się w okienku Viewer. 
# Polecam pobawić się wykresem, tzn. najechac kursorem na punkty, zaznaczyc wybrany obszar.


# Moze pojawić się "warning `arrange_()` is deprecated as of dplyr 0.7.0.", 
# ale nie trzeba sie nim przejmowac, to wina plotly(), a nie nasza.

# Mapowanie kolumn do koloru.
plot_ly(dragons, x = ~height, y = ~weight, color = ~colour, 
        type="scatter", mode="markers")
# Uwaga, dwukrotnie klikajac na elementy legendy mozna wylaczyc wyswietlanie grupy punktow.

# Modyfikacja kolorow legendy
# Ustawienie palety oraz uzycie jej za pomoca parametru `colors`.
pal <- levels(dragons$colour)
plot_ly(dragons, x = ~height, y = ~weight, color = ~colour, 
        type="scatter", mode="markers",
        colors = pal)


# Modyfikacja osi
# Wygląd wykresu modyfikuje się funkcją `layout`.
# tu ograniczamy akres na osi x 
x_ranged <- list(range = c(30, 50))
plot_ly(dragons, x = ~height, y = ~weight, type="scatter", mode="markers") %>% 
  layout(xaxis = x_ranged)

# Mozna modyfikowac duzo wiecej
yaxis <- list(
  title = "HEIGHT", # tytul na osi
  dtick = 1, # co ile mają być zaznaczone liczby na osi
  tickwidth = 4, # szerokość ticka
  tickcolor = "#903278" # kolor ticka
)
plot_ly(dragons, x = ~height, y = ~weight, type="scatter", mode="markers") %>% 
  layout(yaxis = yaxis)

# Przyklad usuniecia wszystkich linii
ax <- list(
  title = "",
  showticklabels = FALSE,
  showgrid = FALSE
)
# Ta sama lista modyfikacji moze zostac uzyta do modyfikacji roznych czesci wykresu,
# tu xaxis i yaxis
plot_ly(dragons, x = ~height, y = ~weight, type="scatter", mode="markers") %>% 
  layout(xaxis = ax, yaxis = ax)


#### WYKRES LINIOWY ####

# Na potreby wiekszej przejrzystosci, tworzymy maly zbior danych, skladajacy sie z 
# 10 wylosowanych obserwacji.
set.seed(123)
dragons_small <- dragons[sample(1:nrow(dragons), 10),]

# Uzywajac mode = "lines" dostajemy wykres liniowy.
plot_ly(dragons_small, x = ~height, y=~weight, type="scatter", mode = "lines")
# Uwaga, linie sa ze soba polaczone zgodnie z kolejnoscia w zbiorze danych, 
# stad dziwny wzor.


# Trzeba posortowac punkty.
dragons_small <- dragons_small %>% arrange(height)
plot_ly(dragons_small, x = ~height, y=~weight, type="scatter", mode = "lines")

# Mozna rysowac tez linie i punkty.
plot_ly(dragons_small, x = ~height, y=~weight, type="scatter", mode = "markers+lines")


#### WYKRES SLUPKOWY ####

# Podajac tylko kolumne kategoryczna dostajemy wykres slupkowy ze zliczeniami.
plot_ly(dragons, x = ~colour)

# Mozna oczywiscie rowniez podac wlasne wartosci dla slupkow.
# W tym celu policzmy ile razy wystepuje kazdy z kolorow.
dragons_counted <- dragons %>% 
  count(colour) %>% 
  arrange(n)
dragons_counted

plot_ly(data = dragons_counted, 
        x = ~colour, 
        y = ~n, 
        type = "bar")

# Jesli chcemy zmienic kolejnosc slupkow, to nalezy zmienic kolejnosc poziomow w factorze.
dragons_counted$colour <- factor(dragons_counted$colour, levels = dragons_counted$colour)
plot_ly(data = dragons_counted, 
        x = ~colour, 
        y = ~n, 
        type = "bar")

# Poziomy wykres otrzymujemy przez parametr `orientation`.
plot_ly(data = dragons_counted, 
        x = ~n,
        y = ~colour, 
        type = "bar",
        orientation = "h")


# Parametr `text` pozwala na wybor jaki tekst ma sie pojawic po najechaniu kursorem na
# slupek. W tym przpadku ma to byc pierwsza litera koloru.
plot_ly(data = dragons_counted, 
        x = ~colour, 
        y = ~n, 
        text = substr(dragons_counted$colour, 1, 1),
        type = "bar")

# Słupki mozna tez rysowac obok siebie.
# W tym celu utworzymy kolumne kategoryczna na podstawie kolumny scars.
# Kolumne podzielimy funkcja `cat()` na dwa przedzialy [0,7] i (7,76].
summary(dragons$scars)
dragons$scars_cat  <- cut(dragons$scars, breaks = c(0, 7, 76), include.lowest = TRUE)
# Licznosci kategorii.
table(dragons$scars_cat)

# Slupki obok siebie
plot_ly(dragons, x = ~colour, y = ~height, color = ~scars_cat,  type = 'bar') %>% 
  layout(legend=list(title=list(text='Scars')))

# Slupki na sobie.
plot_ly(dragons, x = ~colour, y = ~height, color = ~scars_cat,  type = 'bar') %>% 
  layout(legend = list(title=list(text='Scars')),
         barmode = 'stack')



#### BOXPLOT ####

# Mozna podac tylko jedna kolumne mapowana do osi y.
plot_ly(dragons, y = ~height, type = "box", name = "height")

# Ale mozna rowniez podac kolumny, ktore maja byc mapowane do x i y.
plot_ly(dragons, x = ~colour, y = ~height, type = "box")

# Podzial jeszcze ze wzgledu na kolor.
plot_ly(dragons, x = ~colour, y = ~height, color = ~scars_cat,
        type = "box") %>% 
  layout(boxmode = "group")
# Uwaga, moze pojawic sie komunikat
#  'layout' objects don't have these attributes: 'boxmode', 
# Ale zgodnie z https://github.com/ropensci/plotly/issues/994 jest to false positive warning.



#### WYKRES SKRZYPCOWY ####

plot_ly(dragons, y = ~height, color = ~scars_cat,
        type = "violin")

# Mozna dodać boxplota na wierzchu.
plot_ly(dragons, y = ~height, color = ~scars_cat,
        type = "violin", 
        box = list(
          visible = T
        ))

# Oraz wszystkie  punkty  
plot_ly(dragons, y = ~height, color = ~scars_cat,
        type = "violin", 
        box = list(
          visible = T
        ),
        points = "all")


#### HISTOGRAM ####

plot_ly(dragons, x = ~height, type = "histogram")


#### TRACES ####
# Inny sposob jak dodawac kolejne grupy na wykresie. 
# Mozna sie z nim spotkac w czesci przykladow.

# Generujemy trzy rozne wersje danych. 
x <- c(1:100)
trace_0 <- rnorm(100, mean = 5)
trace_1 <- rnorm(100, mean = 0)
trace_2 <- rnorm(100, mean = -5)

data_points <- data.frame(x, trace_0, trace_1, trace_2)
head(data_points)

# Tak jak wczesniej, rysujemy wykres punktowy.
plot_ly(data_points, x = ~x, y = ~trace_0, 
        type = "scatter", mode = "lines")

# Gdybysmy chcieli trace_0, trace_1 oraz trace_2 umiescic razem na wykresie, to
# mozna przeksztalcic dane do postaci dlugiej a potem zamapowac grupy kolorem.
data_long <- data_points %>% 
  pivot_longer(cols = c("trace_0", "trace_1", "trace_2"), 
               names_to = "trace", 
               values_to = "value")
plot_ly(data_long, x = ~x, y = ~value, color = ~trace,
        type = "scatter", mode = "lines")

# Ale mozna uzyc tez funkcji `add_trace()`.
# W kazdym uzyciu mozna od nowa zdefiniowac mapowanie kolumn do atrybutow oraz typ wykresu.
# Mozna o tym myslec jako odpowiedniku funkcji geom_... w ggplot, gdzie dodajemy kolejne warstwy.
plot_ly(data_points, x = ~x) %>% 
  add_trace(y = ~trace_0, name = 'trace 0', type = "scatter", mode = 'lines') %>% 
  add_trace(y = ~trace_1, name = 'trace 1', type = "scatter", mode = 'lines+markers') %>% 
  add_trace(y = ~trace_2, name = 'trace 2', type = "scatter", mode = 'markers')

# Jeszcze estetyczna zmiana tytulu na osi y.
plot_ly(data_points, x = ~x) %>% 
  add_trace(y = ~trace_0, name = 'trace 0', type = "scatter", mode = 'lines') %>% 
  add_trace(y = ~trace_1, name = 'trace 1', type = "scatter", mode = 'lines+markers') %>% 
  add_trace(y = ~trace_2, name = 'trace 2', type = "scatter", mode = 'markers') %>%
  layout(title = 'Traces example',
         yaxis=list(title="y"))


#### ggplotly ####
# Zamiast robic wykresy w plotly mozna wykres w ggplot przeksztalcic na wykres w plotly
# uzywajac funkcji `ggplotly()`.
p <- ggplot(dragons, aes(x = colour, y = height, fill = colour)) +
  geom_boxplot()
ggplotly(p)

# Jesli ktos ma swietnie opanowanego ggplota, to funkcja ggplotly() jest zazwyczaj najwygodniejsza.
# Jednak warto miec na uwadze, ze nie zawsze działa idealnie.
# Przyklad, kiedy nie ggplotly() nie radzi sobie z legenda.
p2 <- ggplot(dragons, aes(x = colour, y = height, fill = colour)) +
  geom_boxplot() +
  theme(legend.position = "bottom")
p2

ggplotly(p2)

# Zeby poprawic polozenie legendy i tak trzeba uzyc funkcji `layout()` z plotly.
ggplotly(p2) %>%
  layout(legend = list(orientation = 'h', x = 0.35, y = -0.2))


#### Zadania ####
# Zadania polegają na odtworzeniu podanych nizej wykresow uzywajac funkcji plot_ly() nie ggplotly(). 
# Theme nie musi byc identyczny.

# a)
ggplot(dragons, aes(x = colour, y = height)) +
  geom_boxplot()



# b)
ggplot(dragons, aes(x = colour, y = height, fill = colour)) +
  geom_violin() +
  geom_boxplot()



# c)
ggplot(dragons, aes(x = scars)) +
  geom_bar()


# d)
# moze byc potrzebne ustawienie `zeroline = FALSE` dla osi x.
set.seed(1)
dragons_sample <- dragons[sample(1:nrow(dragons), 100), ]
ggplot(dragons_sample, aes(x = year_of_birth, y = life_length, color = colour)) +
  geom_point() +
  geom_line() +
  labs(title = "Plot", x = "Year of birth", y = "Life length")

# e)
dragons$scars_cat  <- cut(dragons$scars, breaks = c(0, 7, 76), include.lowest = TRUE)

ggplot(dragons, aes(x = colour, fill = scars_cat)) +
  geom_bar(position = "dodge") + 
  theme(legend.position = "left")




