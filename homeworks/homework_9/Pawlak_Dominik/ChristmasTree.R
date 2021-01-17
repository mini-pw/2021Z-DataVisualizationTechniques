library(ggplot2)
library(gganimate)
library(transformr)

x <- c(3, 2, 2.5, 1.5, 2, 1, 1.5, 0.5, 1, 0)
y <- c(1, 2, 2, 3, 3, 4, 4, 5, 5, 6)

stomp <- data.frame(
  x = c(0.5, 0.5, -0.5, -0.5), 
  y = 2 * c(0, 1, 1, 0))

data <- data.frame(
  x = c(x, rev(-x)),
  y = 2 * c(y, rev(y))
)

baubles1 <- data.frame(
  x = seq(-2, 2, by = 0.5),
  y = 3)
baubles2 <- data.frame(
  x = seq(-1.5, 1.5, by = 0.5),
  y = 5)
baubles3 <- data.frame(
  x = seq(-1, 1, by = 0.5),
  y = 7)
baubles4 <- data.frame(
  x = seq(-0.5, 0.5, by = 0.5),
  y = 9)

x = seq(-3, 3, by = 0.01)
chain1 <- data.frame(
  x,
  y = 1/5 * sin(100*x) + 2)

x = seq(-2.5, 2.5, by = 0.01)
chain2 <- data.frame(
  x,
  y = 1/5 * sin(100*x) + 4)

x = seq(-2, 2, by = 0.01)
chain3 <- data.frame(
  x,
  y = 1/5 * sin(100*x) + 6)

x = seq(-1.5, 1.5, by = 0.01)
chain4 <- data.frame(
  x,
  y = 1/5 * sin(100*x) + 8)

x = seq(-1, 1, by = 0.01)
chain5 <- data.frame(
  x,
  y = 1/5 * sin(100*x) + 10)

p <- ggplot(data, aes(x, y)) +
  ylim(c(-0.5, 14)) +
  theme_void() +
  geom_polygon(fill = "darkgreen", color = "black") +
  geom_polygon(data = stomp, aes(x, y)) + 
  geom_point(aes(x = 0, y = 12), shape = "\u2739", size = 50, fill = "gold", color = "gold") +
  geom_point(data = chain1, aes(x, y), color = "coral", shape = "\u2739", size = 3) +
  geom_point(data = baubles1, aes(x, y), size = 10, color = "red") + 
  geom_point(data = chain2, aes(x, y), color = "coral", shape = "\u2739", size = 3) +
  geom_point(data = baubles2, aes(x, y), size = 10, color = "blue") + 
  geom_point(data = chain3, aes(x, y), color = "coral", shape = "\u2739", size = 3) +
  geom_point(data = baubles3, aes(x, y), size = 10, color = "red") + 
  geom_point(data = chain4, aes(x, y), color = "coral", shape = "\u2739", size = 3) +
  geom_point(data = baubles4, aes(x, y), size = 10, color = "blue") + 
  geom_point(data = chain5, aes(x, y), color = "coral", shape = "\u2739", size = 3) +
  transition_layers(layer_length = 1)

anim_save("ChristmasTree_Animation.gif", p)
