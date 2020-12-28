library(ggplot2)
library(gganimate)

### Rysowanie choinki 

t1 <- data.frame(x = c(2.5, 5, 7.5),
                 y = c(-1, 4, -1))
t2 <- data.frame(x = c(3.2, 5, 6.8),
                 y = c(2, 8, 2))
t3 <- data.frame(x = c(4, 5, 6),
                 y = c(6, 12, 6))
pien <- data.frame(x = c(4.5, 5.5, 5.5, 4.5), y = c(-2, -2, -1, -1))
bombki <- data.frame(x = c(4.5, 5.2, 6, 4.3, 4, 5.2, 6.1, 5.1, 4.9, 4.7), 
                     y = c(7.5, 8, 3.5, 3.1, 0.2, 0.9, 0, 4.1, 9, 5), 
                     c = c("a","b","b","c","d","e","a", "d", "f", "i"))
gwiazda <- data.frame(x = c(4.7, 5, 5.3, 5.15, 5.4, 5.1, 5, 4.9, 4.6, 4.85, 4.7), 
                      y = c(10.7, 11.3, 10.7, 11.7, 12.3, 12.3, 13, 12.3, 12.3, 11.7, 10.7))

### Generowanie śniegu 

generate_snowflakes <- function(n_times = 100, n_flakes = 100){
  flake_frame <- data.frame(
    time = rep(1:n_times, n_flakes), 
    flake_num = rep(1:n_flakes, each = n_times), 
    flake_location_x = rep(runif(n_flakes, 2, 8), each = n_times), 
    size = rep(runif(n_flakes, min = 1, max = 3), each = n_times))
  locations_y <- c()
  for(i in 1:n_flakes){
    speed <- floor(10*unique(flake_frame$size)[i])
    start_time <- sample(1:(n_times-speed), 1)
    y_seq <- c(rep(NA, start_time - 1), 
               13 - (14/speed)*(0:speed), 
               rep(NA, n_times - start_time-speed))
    locations_y <- c(locations_y, y_seq)
  }
  flake_frame$flake_locations_y <- locations_y
  flake_frame$size <- flake_frame$size/15
  return(flake_frame)
}
first_snow <- generate_snowflakes(n_times = 100, n_flakes = 100)

### Tworzenie wykresu 

p <- ggplot(first_snow, aes(x = flake_location_x, y = flake_locations_y)) + 
  geom_polygon(data=t1, mapping=aes(x=x, y=y), fill='green4', color='black') +
  geom_polygon(data=t2, mapping=aes(x=x, y=y), fill='green4', color='black') +
  geom_polygon(data=t3, mapping=aes(x=x, y=y), fill='green4', color='black') +
  geom_polygon(data=pien, mapping=aes(x=x, y=y), fill='brown', color='black') +
  geom_polygon(data=gwiazda, mapping=aes(x=x, y=y), fill='yellow', color='black') +
  geom_point(data=bombki,aes(x=x, y=y, color=c), size=8) +
  geom_point(aes(group = flake_num, size = size), 
             color = "white", shape = 8) +
  theme_void() +
  theme(legend.position = "none") +
  theme(plot.background = element_rect(fill = "darkblue")) +
  transition_time(time) + 
  shadow_wake(wake_length = 0.05, alpha = FALSE) 

anim_save("choinka.gif", p)