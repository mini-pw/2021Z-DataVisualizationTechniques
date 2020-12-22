library(ggplot2)
library(dplyr)
library(gganimate)
library(gifski)
library(tidyr)

N <- 150

y_begin = runif(N, 5, 10)

snieg <- data.frame(
  x = runif(N, -5, 5),
  y_begin,
  y_end = y_begin - runif(N, 2, 5))

snieg_rep <- pivot_longer(
  snieg, cols = !x, names_to = "y", values_to = "value",
)

bombeczki <- data.frame(
  x1 = c(2, 1.6, 0.5, -0.5, -2, -1.5, 0.3, -0.4, -2, 1.5, -1.5, 1.3, 0, 0.3, -0.3, -0.4, 0.4),
  y1 = c(2, 4, 7, 7, 4, 5, 9, 8, 2, 2.5, 1.8, 1.4, 2, 2.4, 1.8, 6, 5),
  color = sample(c("1", "2", "3"), 17, replace = TRUE)
)

p <- ggplot()+
  geom_polygon(aes(x = c(-2.5, 0, 2.5), y = c(1, 6, 1)), fill = "darkgreen")+
  geom_polygon(aes(x = c(-2, 0, 2), y = c(4, 8, 4)), fill = "forestgreen") +
  geom_polygon(aes(x = c(-1.5, 0, 1.5), y = c(6, 10, 6)), fill = "green") +
  geom_polygon(aes(x = c(-0.4, 0.4, 0.4, -0.4), y = c(0, 0, 1, 1)), fill = "brown") +
  geom_point(aes(x = 0, y = 10), shape = 8, size = 7, color = "yellow")+
  geom_point(aes(x = x, y = value), data = snieg_rep, color = "white", size = 6, shape = "*") +
  transition_states(y, transition_length = 1, state_length = 0.1, wrap = FALSE) +
  geom_point(aes(x = x1, y = y1, colour = color), data = bombeczki, size = 5) +
  exit_shrink() +
  scale_color_manual(values = c("orange", "purple", "pink")) +
#  transition_states(color, transition_length = 1, state_length = 1, wrap = FALSE) +
  theme_void() +
  theme(panel.background = element_rect(fill = "blue")) +
  theme(legend.position = "none")
animate(plot = p, duration = 1.5, fps = 20)

anim_save("choinka.gif")

# nie wiedzialem, ¿e niestety nie da sie dodac animacji do kazdej warstwy oddzielnie :(, 
# dlatego jest ten komentarz powyzej
