library(ggplot2)
library(gganimate)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

d <- 0.1

tree <- data.frame(x = c(seq(0, 1, d*0.5), 
                         seq(0, 0.25, d*0.5), seq(0, 0.25, d*0.5), 
                         seq(0.75, 1, d*0.5), seq(0.75, 1, d*0.5)), 
                   y = c(rep(0, (1 - 0)/(d*0.5) + 1), 
                         rep(1, (0.25 - 0)/(d*0.5) + 1), rep(2, (0.25 - 0)/(d*0.5) + 1), 
                         rep(1, (1 - 0.75)/(d*0.5) + 1), rep(2, (1 - 0.75)/(d*0.5) + 1)))

tree <- rbind(tree, data.frame(y = c(seq(0, 1, d), seq(1, 2, d),
                                     seq(0, 1, d), seq(1, 2, d),
                                     seq(2, 4, d), seq(2, 4, d)), 
                               x = c(seq(0, 1, d) * 0.25, seq(0, 1, d) * 0.25,
                                     -(seq(0, 1, d) - 1/0.25)* 0.25, -(seq(0, 1, d) - 1/0.25) * 0.25,
                                     (seq(2, 4, d) - 2) / 4, (-seq(2, 4, d) + 6) / 4)))

tree$times <- tree$y * 10 + 1
N <- nrow(tree)

for(i in 1:N) {
  for(j in 1:tree$times[i]) {
    tree <- rbind(tree, data.frame(x = tree$x[i], y = tree$y[i], times = j))
  }
}

tree$times <- factor(tree$times, levels = seq(41, 1, -1))

tree_plot <- ggplot(data = tree, aes(x = x, y = y)) + 
  theme_void() + 
  geom_point(shape = 21, color = "darkgreen", size = 2)

anim <- tree_plot +
  transition_states(times) +
  enter_fade()

anim_save(file = "just_a_tree.gif", animation = anim)
