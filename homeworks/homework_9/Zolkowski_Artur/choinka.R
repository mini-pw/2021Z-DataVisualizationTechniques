library(ggplot2)
library(gganimate)
library(ggimage)

d <-data.frame(x=c(8,3,13, 8,4,12, 8,5,11, 8,6,10, 8,6.5,9.5),
               y=c(5,1,1, 7,3,3, 9,5,5, 11,7,7, 13,9,9),
               t=c('a', 'a', 'a',  'b', 'b', 'b', 'c', 'c', 'c', 'd', 'd', 'd', 'e', 'e', 'e'),
               r=c(1,2,3, 4,5,6, 7,8,9, 10,11,12, 13,14,15))


balls <- data.frame(x=c(6,  10, 8,  7.1,8.3,8.7,7.4,9.5,6,  8.1, 8.2),
                    y=c(2.3,1.5,3.2,6.1,4.6,7.9,9.5,5.3,4.6,11.5,1.8),
                    c = c("a","b","i","c","d","e","a", "d", "f", "i","f"))

star <- data.frame(x=c(8), y=c(13))


generate_snow <- function(n_times = 100, n_flakes = 300){
  flake_frame <- data.frame(
    time = rep(1:n_times, n_flakes), 
    flake_num = rep(1:n_flakes, each = n_times), 
    flake_location_x = rep(runif(n_flakes, 2, 14), each = n_times), 
    size = rep(runif(n_flakes, min = 1, max = 6), each = n_times))
  locations_y <- c()
  for(i in 1:n_flakes){
    speed <- floor(8*unique(flake_frame$size)[i])
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
snow <- generate_snow(n_times = 100, n_flakes = 500)

p <- ggplot(snow, aes(x = flake_location_x, y = flake_locations_y)) +
  geom_polygon(data=d, mapping=aes(x=x, y=y, group=t), fill='#339966', color='black')+
  geom_text(x=8, y=13,label="???", size=25, family = "HiraKakuPro-W3",color="yellow") +
  geom_point(data=balls,aes(x=x, y=y, color=c), size=6 )+
  geom_point(aes(group = flake_num, size = size), 
             color = "white", shape = 8) +
  theme_void()+
  theme(legend.position = "none") +
  theme(panel.background = element_rect(fill = 'darkblue')) +
  transition_time(time)

anim_save("choinka.gif", p)


