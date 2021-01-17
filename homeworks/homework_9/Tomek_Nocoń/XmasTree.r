library(ggplot2)
library(gganimate)
library(gifski)


drawTriangle <- function(h, x, y, step){
  n1 = (h%/%step) + 1
  n2 = h%/%step
  vector = c()
  for (v in seq((y-h), y, step))
  {
    vector = c(vector, seq((y-h), v, step))
  }
  for (v in seq((y-step), (y-h), -step))
  {
    vector = c(vector, seq(v, (y-h), -step))
  }
  
  df <- data.frame(
    "pointsOfTreeX" = rep(seq((x-h), (x+h), step), times = c(c(1:n1), c(n2:1))),
    "pointsOfTreeY" = vector)
}

colorGreen <- c("olivedrab4", "olivedrab3", "olivedrab2", "olivedrab1", "olivedrab")

df <- drawTriangle(2,2,4,1/16)
t <- rep(1:3, each = nrow(df))
df <- cbind(df, t)
df1 <- drawTriangle(3,2,3,1/16)
t <- rep(1:3, each = nrow(df1))
df1 <- cbind(df1, t)
df2 <- drawTriangle(4,2,1,1/16)
t <- rep(1:3, each = nrow(df2))
df2 <- cbind(df2, t)
df3 <- rbind(df, df1, df2)
colIdx <- sample.int(5,nrow(df3), replace = TRUE)
df3 <- cbind(df3, colorGreen[colIdx])

p <- ggplot(data = df3, aes(x = pointsOfTreeX, y = pointsOfTreeY)) +
  geom_point(shape = df3$pointsOfTreeX, size = df3$t, color = df3$`colorGreen[colIdx]`) +
  theme_void()

p

choinka_gif <- p +
  transition_states(
    t,
    transition_length = 1,
    state_length = 0.0005
  )

animate(choinka_gif, nframes = 20, fps = 30, width = 1000, height = 1200,
        renderer = gifski_renderer('XmasTree.gif'))

