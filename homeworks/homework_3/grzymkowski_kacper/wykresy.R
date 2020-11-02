library(dplyr)
library(SmarterPoland)
library(ggplot2)

data("countries")

countries %>%
  group_by(continent) %>%
  summarise(count = n()) ->
  actual

# nie chce mi się bawić w factory
# pierwszy to c(51, 33, 46, 40, 15)
# drugi to c(42, 57, 22, 63, 51)

czarny <- function() {
  actual %>%
    ggplot() +
    geom_col(aes(x = continent, y = count)) +
    scale_x_discrete(labels = as.character(1:5)) +
    labs(y = "", x ="")
}

mixed <- actual
mixed$count <- floor(actual$count * 1.15) + 5
mixed$continent = factor(actual$continent, levels = c("Americas", "Asia", "Oceania", "Africa", "Europe"))

kolorowy <- function() {
  mixed %>%
    ggplot(aes(x = continent, y = count)) +
    geom_col(aes(fill = continent), show.legend = FALSE) +
    scale_x_discrete(labels = as.character(1:5) ) +
    labs(y = "", x ="")
}


