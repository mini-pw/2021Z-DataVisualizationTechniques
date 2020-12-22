df <- data.frame("x" = c(-5:5, -4:4, -3:3, -2:2, -4:4,-3:3,-2:2, -2:2, -2:2, -1:1, 0), 
                 "y" = c(rep(1, times = 11),rep(2, times = 9),rep(3, times = 7),rep(4, times = 5),rep(5, times = 9),rep(6, times = 7),rep(7, times = 5),rep(8, times = 5),
                          rep(9, times = 5), rep(10, times = 3),11))

a <- sample(1:64, size = 40)
df <- df %>% mutate(z = rep("a", times = 67))
df$z[a[1:10]] <- "b"
df$z[a[11:20]] <- "c"
df$z[a[21:30]] <- "d"
df$z[a[31:40]] <- "e"

df1 <- data.frame(x1 = df$x, y1 = df$y, z1 = df$z)
df1
library(dplyr)
library(ggplot2)
library(gganimate)
library(gifski)

pl <- ggplot(data = df, aes(x = x, y = y)) + geom_point(size = 28, shape = 17, color = "green") + scale_y_continuous(limits = c(0, 12)) + 
  scale_x_continuous(limits = c(-6,6)) + geom_point(data = df1,inherit.aes = FALSE,  aes(x = x1, y = y1, color = z1), size = 5) +
  scale_color_manual(values = c("green", "red", "blue", "orange", "purple", "yellow"))  + theme_void() + theme(legend.position = "None") +
  transition_states(z1, transition_length = 0.02, state_length = 0.02)  + 
    enter_fade() + exit_fade()


anim_save("tree.gif", pl)

                       