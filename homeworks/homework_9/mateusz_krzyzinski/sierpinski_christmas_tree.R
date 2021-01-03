library(ggplot2)
library(gganimate)
library(dplyr)

vertices <- data.frame(x = c(0, 0.5, 1), y = c(0, sqrt(3)/2, 0))

midpoint <- function(coord1, coord2){
  0.5 * (coord1 + coord2)
}

n_points <- 3000

sierpinski <- 
  data.frame(
    step = 1:n_points,
    x = rep(0, n_points),
    y = rep(0, n_points),
    color = rep("green4", n_points), 
    size = rep(1, n_points),
    shape = rep(19, n_points),
    stringsAsFactors = FALSE
  )


for (step in 2:n_points) {
  rand <- sample(1:3, 1)
  sierpinski[step, "x"] <-
    midpoint(
      sierpinski[step - 1, "x"], vertices[rand, "x"]
    )
  
  sierpinski[step, "y"] <-
      midpoint(
        sierpinski[step - 1, "y"], vertices[rand, "y"]
      )
}

balls <- sierpinski[sample(1:n_points, 50), ] 
balls$step <- seq(n_points+1, n_points+50)
balls$color <- c("blue", "red")
balls$size <- 3

sierpinski <- rbind(sierpinski, balls)

data.frame(step = nrow(sierpinski):(nrow(sierpinski)+49), 
           x = 0.5, y = sqrt(3)/2,
           color = "gold",  size = 18, shape = 8) -> star

sierpinski <- rbind(sierpinski, star)

data.frame(step = nrow(sierpinski):(1.2 * nrow(sierpinski)), 
           x = 0, y = 0, color="green4", size=1, shape=19) -> stay

sierpinski <- rbind(sierpinski, stay)

ggplot(data = sierpinski, aes(x, y) ) + 
  geom_point(color =  sierpinski$color, size = sierpinski$size, shape = sierpinski$shape) +
  theme_void() +
  ggtitle(label = "Sierpiński triangle - christmas edition", subtitle = "or: 'Krzyziński christmas tree'" ) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5)) -> plot

plot + transition_manual(frames = step, cumulative = TRUE)
