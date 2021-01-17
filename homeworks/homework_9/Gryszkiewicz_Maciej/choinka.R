library(gganimate)
library(gifski)
library(ggiraph)
library(ggplot2)
library(png)

drzewo = data.frame(x = c(-4, 4, 0,  -2, 2, 0,  -0.5, 0.5, 0,  -0.25, 0.25, 0,  -0.25, 0.25, 0,  -0.5, 0.5, -0.5,  -0.5, 0.5, 0.5), 
               y = c(1, 1, 4,  3, 3, 5,  4.75, 4.75, 5.5,  5.4, 5.4, 5.833,   5.68867, 5.68867, 5.255667,  0.5, 0.5, 1,  1, 1, 0.5), 
                     group = rep(c('a', 'b', 'c', 'd', 'e', 'f', 'g'), each = 3))

drzewo_dol <- c(-3, 3, 0, -3, 1, 1, 5.5, 1)
dim(drzewo_dol) <- c(4, 2)

polygon <- sp::Polygon(drzewo_dol)
bombki <- sp::spsample(polygon, n = 60, type = 'random')
bombki <- as.data.frame(sp::coordinates(bombki))

snieg <- data.frame(x = runif(1200, -4.5, 4.5), y = runif(1200, 0, 60))

choinka <- ggplot() + 
  geom_polygon(data = drzewo, mapping = aes(x = x, y = y, group = group, fill = rep(c('g', 'g', 'g', 'y', 'y', 'z', 'z'), each = 3))) + 
  theme_void() +
  theme(legend.position = "none") +
  scale_fill_manual(values = c("#1E3F20", "#F3DE8A", "#513A15")) +
  geom_point(data = bombki, mapping = aes(x = x, y = y, color = sample(1:8, length(x), replace = TRUE)), size = 4) +
  scale_color_gradientn(colours = rainbow(8)) +
  theme(panel.background = element_rect(fill = "#141c3a", colour = "#141c3a")) +
  geom_point(snieg, mapping = aes(x = x, y = y), color = 'white') +
  coord_cartesian(ylim = c(0, 6), xlim = c(-4.5, 4.5))

choinka

# bombki$sort <- floor((bombki$y * 1000000) %% 2)
bombki$sort <- 1
bombki[1,] <- c(-6, 3, 0)

# snieg$sort <- floor(snieg$y) %/% 10
anim <- choinka + 
  transition_states(bombki$sort, transition_length = 1, state_length = 3) +
  enter_drift(x_mod = -6) +
  exit_drift(x_mod = 6) +
  enter_fade() +
  enter_grow() +
  exit_fade()
anim