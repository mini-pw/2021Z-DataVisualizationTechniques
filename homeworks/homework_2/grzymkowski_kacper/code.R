library(dplyr)
library(tidyr)
library(ggplot2)
library(stringr)

# funkcja zamieniająca format pliku na format odpowiedni dla R 
# (usuwa procenty, zamienia na liczby i dzieli przez 100)
polski_procent_do_R <- function(var) { 
  var %>% 
    as.character() %>%
    str_replace("%", "") %>% 
    str_replace(",", ".") %>% 
    as.numeric() / 100 
}

# Kolory takie jak w danych
color_order <- c("Purple", "Blue", "Green", "Yellow", "Gold", "Biege", "Brown", "Red", "Burgundy",
                 "White", "Silver", "Gray", "Black", "Other")
# Kolory żeby ggplot rozumiał i stylistycznie dobrane ("brown" jest bardziej pomarańczowy niż "darkorange4")
color_ggplot <- c("purple", "blue", "green", "yellow", "gold3", "tan", "darkorange4", "red", "red4",
                  "white", "gray60", "gray30", "black", "gold3")

read.csv("data.txt", sep ="\t") -> cars_color

cars_color %>%
  mutate_at(vars(-("Year")), polski_procent_do_R) %>%
  pivot_longer(2:ncol(cars_color), names_to="Color") ->
  cars_color_processed

# Zamiana koloru samochodu na factor 
cars_color_processed$Color <- factor(cars_color_processed$Color, levels = color_order)

recreated <- function() {
cars_color_processed %>%
  ggplot(aes(x = factor(Year), y = value, fill = Color)) +
  geom_bar(stat = "identity",  color = "black", size = 0.05) +
  scale_fill_manual(values = color_ggplot) +
  scale_y_continuous("", labels = scales::percent) +
  scale_x_discrete(name = "Year of production", breaks = 1990:2020, labels = as.character(1990:2020)) + 
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(),
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) + 
  ggtitle("Car color distribution broken down by production year")
}

cars_color %>%
  mutate_at(vars(-("Year")), polski_procent_do_R) %>%
  mutate(Other = Biege + Brown + Purple + Gold + Yellow) %>%
  select(-c("Biege","Brown", "Purple", "Gold", "Yellow")) %>%
  pivot_longer(2:10, names_to="Color") ->
  cars_color_improved

cars_color_improved$Color <- factor(cars_color_improved$Color, levels = color_order)
  
color_ggplot_improved  <- c("blue", "green", "red", "red4",
                          "white", "gray80", "gray50", "black", "gold3")

improved <- function() {
cars_color_improved %>%
  ggplot(aes(x = factor(Year), y = value, group= Color)) +
  geom_line(color = "black", size = 1.5) + # outline, żeby było widać białą
  geom_line(aes(color =  Color), size = 1.2) +
  scale_color_manual(values = color_ggplot_improved) +
  scale_y_continuous("", labels = scales::percent) +
  scale_x_discrete("Year of production", breaks = 1990:2020, labels = as.character(1990:2020)) + 
  theme_light() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), axis.title.x.bottom = element_text(vjust = -1)) +
  ggtitle("Car color distribution broken down by production year")
}

