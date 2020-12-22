library(ggplot2)
library(gganimate)

x <- seq(-4,4, length.out=200)

y <- dnorm(x, 0, .8)
ymin <- 0

y1 <- dnorm(x, 0, 0.5) + 0.4
y1min <- 0.4

y2 <- dnorm(x, 0, 0.5) + 0.8
y2min <- 0.8

y3 <- dnorm(x, 0, 0.5) + 1.2
y3min <- 1.2

stump_X <- seq(-0.25, 0.25, length.out = 2)
stump_high <- rep(0,2)
stump_low <- rep(-0.2, 2)


x_bom <- c(-1,-0.9, 1, 0.8, 0.2,0.15,-0.13, -0.5, -0.1, -0.7, -0.3, 0.3, 0.5, -0.25)
y_bom <- c(0.82, 0.5, 0.1, 0.5, 1.25, 0.75, 1.8, 1.5, 0.25, 0.08, 1, 1.6, 0.9, 0.6)

snow_x <- runif(300, -4, 4)
snow_y <- runif(300, -0.2, 6)

snow <- data.frame( x=c(snow_x, snow_x), y = c(snow_y, snow_y-3), fallen = c(rep("1", 300), rep("2", 300)))


ggplot() +
  theme(panel.grid.major.x = element_line(color="#122480"), panel.grid.major.y = element_line(color="#122480"), panel.grid.minor = element_line(color="#122480"), panel.background = element_rect(fill="#122480")) +
  geom_ribbon(aes(x=stump_X, ymax=stump_high, ymin=stump_low), fill="#5e2f0a") +
  geom_ribbon(aes(x=x, ymax=y, ymin=ymin), fill="#056111") +
  geom_ribbon(aes(x=x, ymax=y1, ymin = y1min), fill="#056111") +
  geom_ribbon(aes(x=x, ymax=y2, ymin = y2min), fill="#056111") +
  geom_ribbon(aes(x=x, ymax=y3, ymin = y3min), fill="#056111")+
  geom_point(aes(x=x_bom, y=y_bom), size=8, color = "#ff2a00", alpha=0.8) +
  geom_point(data = snow, mapping = aes(x=x, y=y), color="#ffffff") +
  transition_states(fallen, transition_length = 5, state_length = 1, wrap=FALSE) + view_zoom(fixed_x = c(-3,3), fixed_y = c(-0.2,2)) -> p

  animate(p) + anim_save("c.gif")

  