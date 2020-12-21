library(ggplot2)
library(gganimate)
library(gifski)
library(dplyr)

# punkty choinki
n = 1e5

z <- as.data.frame(list(replicate(n, 0), replicate(n, 0)))
colnames(z) <- c("X", "Y")


for (i in 2:n){
  t = runif(1)
  
  if (t <= 0.32){
    z[[1]][i] = -0.67 * z[[1]][i-1] - 0.02 * z[[2]][i-1]
    z[[2]][i] = -0.18 * z[[1]][i-1] + 0.81 * z[[2]][i-1] + 10
    
  } else if (t <= 0.64){
    z[[1]][i] = 0.4 * z[[1]][i-1] + 0.4 * z[[2]][i-1]
    z[[2]][i] = -0.1 * z[[1]][i-1] + 0.4 * z[[2]][i-1]
  
  } else if (t <= 0.96){
    z[[1]][i] = -0.4 * z[[1]][i-1] - 0.4 * z[[2]][i-1]
    z[[2]][i] = -0.1 * z[[1]][i-1] + 0.4 * z[[2]][i-1]  
    
  } else{
    z[[1]][i] = -0.1 * z[[1]][i-1]
    z[[2]][i] = 0.44 * z[[1]][i-1] + 0.44 * z[[2]][i-1] - 2
  }
  
}

x_max = max(z[[1]])
x_min = min(z[[1]])
y_max = max(z[[2]])
y_min = min(z[[2]])

for (i in 1:n){
  z[[1]][i] = (z[[1]][i] - x_min)/(x_max - x_min)
  z[[2]][i] = (z[[2]][i] - y_min)/(y_max - y_min)
}

# gwiazda 
g <- as.data.frame(list(c(0.48, 0.48), c(0.98, 0.98)))
colnames(g) <- c("X", "Y")

# bombki
b <- as.data.frame(list(c(0.03, 0.32, 0.61, 0.34, 0.3, 0.78, 0.88, 0.48, 0.6, 0.72, 0.46, 0.2, 0.98, 0.46, 0.28, 0.77, 0.66, 0.37), 
                        c(0.44, 0.10, 0.25, 0.65, 0.25, 0.58, 0.19, 0.47, 0.7, 0.11, 0.12, 0.21, 0.44, 0.75, 0.41, 0.28, 0.4, 0.35), 
                        c("blue", "yellow", "blue", "orange", "pink", "red", "yellow", "orange", "pink", "red", "red", "orange", "pink", "blue", "yellow", "orange", "yellow", "blue")))

colnames(b) <- c("X", "Y", "col")

# płatki śniegu
n_times = 100
n_flakes = 100

flake_frame <- data.frame(
  time = rep(1:n_times, n_flakes), 

  flake_num = rep(1:n_flakes, each = n_times), 

  flake_location_x = rep(runif(n_flakes), each = n_times), 
 
  size = rep(runif(n_flakes, min = 0.3, max = 1), each = n_times))

locations_y <- c()
for(i in 1:n_flakes){

  speed <- floor(10*unique(flake_frame$size)[i])

  start_time <- sample(1:(n_times-speed), 1)

  y_seq <- c(rep(NA, start_time - 1), 
             1 - (1/speed)*(0:speed), 
             rep(NA, n_times - start_time-speed))
  locations_y <- c(locations_y, y_seq)
}
flake_frame$flake_locations_y <- locations_y

flake_frame$size <- flake_frame$size/15

# animacja
anim <- flake_frame %>%
ggplot(aes(x = flake_location_x, y = flake_locations_y)) +
  geom_point(data = z, aes(x = X, y = Y), color = "darkgreen") +
  geom_point(data = g, aes(x = X, y = Y), shape = c(24, 25), fill = "yellow", size = 5, color = "yellow") +
  geom_point(data = b, aes(x = X, y = Y), size = 4, colour = b$col) +
  annotate(geom="text", x=0.2, y=0.87, label="Merry Christmas!",
           color="yellow", size = 2.7) +
  geom_point(aes(group = flake_num, size = size), color = "white") +
  theme_void() +
  theme(legend.position = "none",
        panel.background = element_rect(fill = "darkblue")) + 
  transition_time(time)

animate(anim, height = 2, width = 2, units = "in", res = 150)
