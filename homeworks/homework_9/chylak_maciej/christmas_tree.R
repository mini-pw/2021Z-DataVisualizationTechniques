library(gganimate)
library(dplyr)
library(ggplot2)

#tree generator

x_root <- runif(100, 6, 8)
y_root <- runif(100, 0, 2)

x_gen_bot <- runif(3000, 2, 12)

x_gen_mid <- runif(1000, 4, 10)

x_gen_top <- runif(500, 5, 9)

y_gen_bot <- 1:length(x_gen_bot)
y_gen_mid <- 1:length(x_gen_mid)
y_gen_top <- 1:length(x_gen_top)

for (i  in 1:length(x_gen_bot)){
  a <- x_gen_bot[i]
  if(a > 7){
    y_gen_bot[i] <- runif(1, 2, -2*a + 26)
  }
  else{
    y_gen_bot[i] <- runif(1, 2, 2*a - 2)
  }
}

for (i  in 1:length(x_gen_mid)){
  a <- x_gen_mid[i]
  if(a > 7){
    y_gen_mid[i] <- runif(1, 10, -2*a + 30)
  }
  else{
    y_gen_mid[i] <- runif(1, 10, 2*a + 2)
  }
}

for (i  in 1:length(x_gen_top)){
  a <- x_gen_top[i]
  if(a > 7){
    y_gen_top[i] <- runif(1, 15, -2*a + 33)
  }
  else{
    y_gen_top[i] <- runif(1, 15, 2*a  + 5)
  }
}

# Star generator
x_star <- c(7, 7)
y_star <- c(19, 19)

#baubles


x_baubles_bot1 <- runif(30, 2, 12)
y_baubles_bot1 <- 1:length(x_baubles_bot1)

x_baubles_mid1 <- runif(20, 4, 10)
y_baubles_mid1 <- 1:length(x_baubles_mid1)

x_baubles_top1 <- runif(10, 5, 9)
y_baubles_top1 <- 1:length(x_baubles_top1)


x_baubles_bot2 <- runif(30, 2, 12)
y_baubles_bot2 <- 1:length(x_baubles_bot2)

x_baubles_mid2 <- runif(20, 4, 10)
y_baubles_mid2 <- 1:length(x_baubles_mid2)

x_baubles_top2 <- runif(10, 5, 9)
y_baubles_top2 <- 1:length(x_baubles_top2)

for (i  in 1:length(x_baubles_bot1)){
  a <- x_baubles_bot1[i]
  b <- x_baubles_bot2[i]
  if(a > 7){
    y_baubles_bot1[i] <- runif(1, 2, -2*a + 26)
  }
  else{
    y_baubles_bot1[i] <- runif(1, 2, 2*a - 2)
  }
  if(b > 7){
    y_baubles_bot2[i] <- runif(1, 2, -2*b + 26)
  }
  else{
    y_baubles_bot2[i] <- runif(1, 2, 2*b - 2)
  }
}
for (i  in 1:length(x_baubles_mid1)){
  a <- x_baubles_mid1[i]
  b <- x_baubles_mid2[i]
  if(a > 7){
    y_baubles_mid1[i] <- runif(1, 2, -2*a + 30)
  }
  else{
    y_baubles_mid1[i] <- runif(1, 2, 2*a + 2)
  }
  if(b > 7){
    y_baubles_mid2[i] <- runif(1, 2, -2*b + 30)
  }
  else{
    y_baubles_mid2[i] <- runif(1, 2, 2*b + 2)
  }
}
for (i  in 1:length(x_baubles_top1)){
  a <- x_baubles_top1[i]
  b <- x_baubles_top2[i]
  if(a > 7){
    y_baubles_top1[i] <- runif(1, 2, -2*a + 33)
  }
  else{
    y_baubles_top1[i] <- runif(1, 2, 2*a + 5)
  }
  if(b > 7){
    y_baubles_top2[i] <- runif(1, 2, -2*b + 33)
  }
  else{
    y_baubles_top2[i] <- runif(1, 2, 2*b + 5)
  }
}



#preparing data_sets

data_root <- data.frame(x = x_root, y = y_root, mark = 0)
data_1 =data.frame(x = x_gen_bot, y = y_gen_bot, mark = 0)
data_2 =data.frame(x = x_gen_mid, y = y_gen_mid, mark = 0)
data_3 =data.frame(x = x_gen_top, y = y_gen_top, mark = 0)
data_star <- data.frame(x=x_star, y = y_star, mark = 0)

data_baubles11 <- data.frame(x = x_baubles_bot1, y = y_baubles_bot1, mark = 1)
data_baubles12 <- data.frame(x = x_baubles_mid1, y = y_baubles_mid1, mark = 1)
data_baubles13 <- data.frame(x = x_baubles_top1, y = y_baubles_top1, mark = 1)

data_baubles21 <- data.frame(x = x_baubles_bot2, y = y_baubles_bot2, mark = 2)
data_baubles22 <- data.frame(x = x_baubles_mid2, y = y_baubles_mid2, mark = 2)
data_baubles23 <- data.frame(x = x_baubles_top1, y = y_baubles_top2, mark = 2)


final_data <- rbind(data_1, data_2, data_3, data_root, data_star, data_baubles11, data_baubles12, data_baubles13, data_baubles21, data_baubles22, data_baubles23)
#settings
color_generator <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
fills <- c(rep("green", times = 4500), rep("brown", times = 100), "yellow", "yellow",  sample(color_generator, size = 120, replace = TRUE))
colors <- c(rep("darkgreen", times = 4500), rep("brown", times = 100), "yellow", "yellow", sample(color_generator, size = 120, replace = TRUE))
sizes <- c(rep(4, times = 4600), 10, 10, rep(5, times = 120))
shapes <- c(rep(23, times = 4600), 24, 25, sample(1:23, 120, replace = TRUE))

#ggplot  
p <- ggplot(final_data, aes(x = x, y = y)) + geom_point(shape=shapes, fill=fills, color = colors, size = sizes) + theme_dark() + ggtitle("Merry Xmas!") + theme(plot.title = element_text(hjust = 0.5), panel.grid.major = element_blank(), panel.grid.minor = element_blank())+ transition_filter(filter_length = 1, transition_length = 1, Long = x > 0, Mark = mark < 1) + enter_fade() + exit_shrink()
anim_save("xmastree.gif", p)
