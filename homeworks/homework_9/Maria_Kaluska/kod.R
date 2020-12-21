library(sp)
library(ggplot2)
library(gganimate)
library(gifski)
#choinka_zielona <- 
num_points <- 5000
x_coords <- c(8, 5, 2)
y_coords <- c(2, 12, 2)
coords <- cbind(x_coords, y_coords)
p <- Polygon(coords)
ps <- Polygons(list(p), 1)
sps <- SpatialPolygons(list(ps))
sizes <- runif(num_points, min=0.5, max=1.5)
colors <- rep(c("#008000", "#006400", "#007200"), as.integer(num_points/3) + 3)
points <- data.frame(spsample(p, n = num_points, "random"))
tree_data <- cbind(points, size=sizes, color=colors[1:num_points], t=rep(1:3, num_points))

tree_data <- rbind(tree_data, tree_data, tree_data)

bombki <- cbind(data.frame(spsample(p, n = 300, "random")), size=rep(3, 300), 
                color=rep(c("#ff7b00", "#ffa200", "#ffd000"), 100), t=rep(1:3, 300))

tree_data <- rbind(tree_data, bombki)
choinka <- ggplot(tree_data, aes(x=x, y=y, size=size, color=color)) +
  geom_point() +
  ylim(c(0,14)) +
  xlim(c(0,10)) +
  scale_color_manual(values=c("#008000", "#006400", "#007200", "#ff7b00", "#ffa200", "#ffd000")) +
  theme_minimal() +
  theme(
    axis.title = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    
    panel.grid = element_blank(),
    
    legend.position = "none"
  )

choinka_gif <- choinka +
  transition_states(
    t,
    transition_length = 1,
    state_length = 0.0006
  )


animate(choinka_gif, nframes = 20, fps = 25, width = 600, height = 800,
        renderer = gifski_renderer('choinka.gif'))
