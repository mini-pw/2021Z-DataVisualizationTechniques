library(ggplot2)
library(gganimate)
library(ggimage)

d <- data.frame(x1 = c(1.7, 1.7, 2,   2,   1.9, 1.9, 2.2, 2.2, 2.25, 2.25, 2.3, 2.3, 2.4, 2.4, 2.5, 2.5, 2.6, 2.6, 2.6, 2.6, 2.7, 2.7, 2.9, 2.9, 3,   3,   3.2, 3.2, 3.3, 3.3), 
                y1 = c(2.2, 2.4, 3.2, 3.4, 1.2, 1.4, 2.5, 2.7, 1.3, 1.5, 2,   2.2, 3.4, 3.6, 3,   3.2, 1.6, 1.8, 3.5, 3.7, 2.5, 2.7, 3.1, 3.3, 1.5, 1.7, 2.2, 2.4, 1.2, 1.4), 
                cat = c("firebrick1", "gold"))

p <- ggplot() +
  geom_polygon(aes(x = c(1, 2, 2), y = c(1, 1, 2)), fill = "forestgreen") +
  geom_polygon(aes(x = c(3, 3, 4), y = c(1, 2, 1)), fill = "forestgreen") +
  geom_polygon(aes(x = c(1.3, 2, 2), y = c(2, 2, 3)), fill = "forestgreen") +
  geom_polygon(aes(x = c(3, 3, 3.7), y = c(2, 3, 2)), fill = "forestgreen") +
  geom_polygon(aes(x = c(1.6, 3.4, 2.5), y = c(3, 3, 4.5)), fill = "forestgreen") +
  geom_rect(aes(xmin=2,xmax=3,ymin=1,ymax=3), fill = "forestgreen") +
  geom_rect(aes(xmin=2.45,xmax=2.65,ymin=0,ymax=1), fill = "saddlebrown") +
  geom_point(data = d, aes(x = x1, y = y1, color = cat), size = 5) +
  scale_color_identity() +
  ylim(c(0, 5)) +
  transition_states(d$cat, transition_length = 2, state_length = 1) +
  geom_image(aes(x = 2.5, y = 4.5, image = "star2.png"), size = 0.2) +
  theme_void() + theme(plot.background = element_rect(fill = 'tan1'))

animate(plot = p, duration = 0.5, fps = 20)