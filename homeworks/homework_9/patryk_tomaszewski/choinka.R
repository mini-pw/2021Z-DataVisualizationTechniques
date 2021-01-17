library(ggplot2)
library(dplyr)
library(tidyr)
library(gganimate)
library(png)
library(gifski)

prec <- 120
colfunc <- colorRampPalette(c("#4e8d7c", "#045762"))
leaf1 <- seq(0.25, prec/12, 0.25)
leaf2 <- seq(prec/24, prec/8, 0.25)
leaf3 <- seq(prec/16, prec/6, 0.25)
leaves <- c(leaf1, leaf2, leaf3)

frame <- 0
addState <- function(order) {
  frame <<- frame+1
  data.frame(
    x = c(order, seq(0, floor(-prec/10)+1, -1)), 
    width=c(leaves, rep(prec/40, floor(prec/10))),
    fill = c(colfunc(length(leaves)), rep("#433d3c",floor(prec/10))),
    frame = frame
  )
}
addTransitionStates <- function(tree) {
  union(tree, addState(sample(1:length(leaves)))) %>% union(addState(sample(1:length(leaves))))
}

normalOrder <- seq(length(leaves), 1, -1)
reverseTriangleOrder <- c(
  seq(length(leaf1), 1, -1),
  seq(length(leaf1)+length(leaf2), length(leaf1)+1, -1),
  seq(length(leaves), length(leaf1)+length(leaf2)+1, -1)
)
sortedOrder <- (data.frame(leaves, pos = 1:length(leaves)) %>% arrange(-leaves) %>% mutate(order = 1:n()) %>% arrange(pos))$order
brokenSortedOrder <- order(-leaves)

tree <- addState(normalOrder) %>% addTransitionStates() %>%
  union(addState(reverseTriangleOrder)) %>% addTransitionStates() %>%
  union(addState(sortedOrder)) %>% addTransitionStates() %>%
  union(addState(brokenSortedOrder)) %>% addTransitionStates()

treeReverse <- mutate(tree, width = -width)
tree <- union(tree, treeReverse)

plot <- ggplot(tree, aes(x = x, y = width, fill = fill)) +
  geom_col(width=1) +
  coord_flip() +
  theme_void() +
  scale_fill_manual(values=c(colfunc(length(leaves)), "#433d3c"), breaks=c(colfunc(length(leaves)), "#433d3c")) +
  theme(
    legend.position = "none",
    plot.background = element_rect(fill = "#222244", color = "#222244"),
    plot.title = element_text(color = "#f3f2da", hjust = 0.5, face = "bold", size=16)
  ) +
  ggtitle("Self-organizing christmas tree") +
  ylim(-prec/4, prec/4) +
  transition_states(frame,
                    transition_length = 1,
                    state_length = 3)

anim <- animate(plot, width = 480, height = 420, fps=30, duration = frame*2)
anim
