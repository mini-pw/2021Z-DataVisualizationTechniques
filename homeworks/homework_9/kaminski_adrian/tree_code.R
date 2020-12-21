library(ggplot2)
library(gganimate)
library(gifski)
library(ggthemes)

set.seed(10)
n <- 20


create_tree <- function(height) {
  width_max <- height/4
  parts <- seq(width_max/7, height, 1)
  widths <- seq(width_max, 0.1, length.out = length(parts))
  widths[length(widths)] <- widths[length(widths)-1]/5
  jump <- parts[2] - parts[1]
  
  
  df <- data.frame(x = runif(parts[1]*n, -widths[1], widths[1]),
                   y = runif(parts[1]*n, parts[1], parts[1] + jump),
                   height = height)
  
  for (k in 2:length(parts)) {
    df <- rbind(df, data.frame(x = runif(sqrt(parts[k])*n, -widths[k], widths[k]),
                                y = runif(sqrt(parts[k])*n, parts[k], parts[k] + jump),
                               height = height))
  }
  df
}
create_root <- function(height) {
  width_max <- height/4
  
  root <- data.frame(x = c(width_max/12,width_max/12 ,-width_max/12 ,-width_max/12),
                     y = c(width_max/7, -width_max/7, width_max/7, -width_max/7),
                     height = height)
  root
}

root <- create_root(5)
tree <- create_tree(5)

for (k in 6:14) {
  root <- rbind(root, create_root(k))
  tree <- rbind(tree, create_tree(k))
}
root$height <- root$height - 4
tree$height <- tree$height - 4

ggplot(tree, aes(x=x, y=y, group = height)) +
  geom_point(color = "green") + 
  geom_point(data=root, aes(x=x, y=y, group = height), color = "brown") + 
  scale_x_continuous(limits = c(-4,4)) +
  scale_y_continuous(limits = c(-1, 15)) +
  transition_states(states = height) +
  labs(title = "Point-converging Christmas tree growth", subtitle = "Age: {closest_state}") +
  theme_void() +
  theme(
    plot.title = element_text(hjust = 0.5,
                              size = 24),
    plot.subtitle = element_text(hjust = 0.1)
  ) -> plot1

anim_save("tree.gif", animate(plot1, fps=20, renderer = gifski_renderer()))
