# install.packages("gganimate", "gifski")
library(gifski)
library(gganimate)

x.val <- c(-2, -1.5, -1.2, -1, -0.92, -0.3, -0.2, 0.1, 0.34, 0.5, 0.9, 1.2, 1.9,
           0, 0.33, -0.7, -2.7, 0.8, -0.1, 0, 1, 2.5, 2.85)
y.val <- c(2.3, 1.3, 2.7, 2.4, 1.7, 4, 2.12, 3.5, 4.5, 3.9, 2.55, 1.3, 2.3,
           3, 1.6, 3.35, 1.2, 3.1, 1.3, 4.8, 2.13, 1.3, 2)
colo <- rep_len(c('yellow', 'red', 'blue'), length.out = length(x.val))
df <- data.frame(x.val, y.val, colo)

snow.x <- rep(seq(from = -5, to = 5, length.out = 60), times = 60)
snow.y <- rep(seq(from = 6.5, to = 0.2, length.out = 60), each = 60)
states <- sample(1:30, 60, replace = T)
for (i in 61:3600) {
  states[i] <- (states[i - 60] + 1) %% 30
}
df_2 <- data.frame(snow.x, snow.y, states_2)

x.1 <- seq(from = -2, to = 0, length.out = 100)
y.1 <- exp(x.1+1)+3
x.2 <- seq(from = 0, to = 2, length.out = 100)
y.2 <- exp(-x.2+1)+3
x.3 <- seq(from = -4, to = -0.9285, length.out = 200)
y.3 <- exp((x.3+7)/5)
x.4 <- seq(from = 0.9285, to = 4, length.out = 200)
y.4 <- exp((7-x.4)/5)
b <- exp(0.6) - exp(0.9285/7)
x.5 <- seq(from = -5.25, to = 0.9285, length.out = 200)
y.5 <- exp(x.5/7+b)+0.1
x.6 <- seq(from = 0.9285, to = 5.25, length.out = 200)
y.6 <- exp(-x.6/7+b)+0.1

p <- ggplot() +
  geom_polygon(aes(x = c(x.1, 0.2), y = c(y.1, exp(-1)+3)), fill = '#1F904C') +
  geom_polygon(aes(x = c(x.2, 0), y = c(y.2, exp(-1)+3)), fill = '#1F904C') +
  geom_polygon(aes(x = c(x.3, 0.2, 0), y = c(y.3, exp(-1)+3.4, exp(0.6))),
               fill = '#1F904C') +
  geom_polygon(aes(x = c(x.4, -0.2, -0.2), y = c(y.4, exp(0.6), exp(-1)+3.4)),
               fill = '#1F904C') +
  geom_polygon(aes(x = c(x.5, -0.2, -0.2), y = c(y.5, exp(0.6), 1.02)),
               fill = '#1F904C') +
  geom_polygon(aes(x = c(x.6, -0.2, -0.2), y = c(y.6, 1.02, exp(0.6)+0.5)),
               fill = '#1F904C') +
  geom_polygon(aes(x = c(-0.8, 0.8, 0.8, -0.8), y = c(1.04, 1.04, 0.2, 0.2)),
               fill = '#7B5516') +
  geom_point(aes(x=0, y=5.8), colour="yellow", size = 15, shape = 8) +
  geom_point(data=df, aes(x=x.val, y=y.val, size=3), colour=colo) +
  geom_point(data=df_2, aes(x=snow.x, y=snow.y, size=2), color='gray', shape=8) +
  ylim(c(0, 6.6)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_blank(),
        axis.title.x=element_blank(), axis.title.y=element_blank(),
        legend.position = "none")


anim <- p + transition_states(states, transition_length = 1, state_length = 1)

animate(anim, renderer = gifski_renderer())
anim_save("christmas_tree.gif")

