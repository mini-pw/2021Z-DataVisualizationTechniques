library(ggplot2)
library(dplyr)
library(ggimage)
library(gganimate)


#tworzenie ramki danych, choinka jest narysowana dzieki funkcji 1/x
bot <- seq(from = -3, to = 3, by = 0.01)
mid <- seq(from = -2, to = 2, by = 0.01)
up <- seq(from = -1, to = 1, by = 0.01)
pal <- c('#00BC59', '#00BE6C', '#00BF7D')

fbot <- abs(1/bot)

df = data.frame("x" = bot, "y" = fbot, "color" = pal[sample(1:3, 1)])

for (i in 1:10){
  x <- data.frame("x" = bot, "y" = abs((1 + i / 10) / bot), "color" = pal[sample(1:3, 1)])
           
  df <- rbind(df, x)
}

df <- rbind(df, data.frame("x" = mid, "y" = abs(1 / mid) + 2, "color" = pal[sample(1:3, 1)]))
for (i in 1:10){
  x <- data.frame("x" = mid, "y" = abs((1 + i / 10) / mid) + 2, "color" = pal[sample(1:3, 1)])
  
  df <- rbind(df, x)
}

df <- rbind(df, data.frame("x" = up, "y" = abs(1 / up) + 4, "color" = pal[sample(1:3, 1)]))
for (i in 1:10){
  x <- data.frame("x" = up, "y" = abs((1 + i / 10) / up) + 4, "color" = pal[sample(1:3, 1)])
  
  df <- rbind(df, x)
}

for(i in 1:9){
  df <- rbind(df, data.frame("x" = bot, "y" = abs((i/10) / bot), "color" = pal[sample(1:3, 1)]))
}


df$color <-as.character(df$color)
df[df$y > 9,][3] <- 'white'

#przygotowanie pnia i gwiazdy
rect <- data.frame(x = c(-0.25, -0.25, 0.25, 0.25), y = c(-0.5, 10, 10, -0.5))
img <- data.frame(x = 0, y = 10, image = "star.png")

#ramka danych z bombkami, losowe 90 punktow z choinki
baubles <- df[sample(1:dim(df)[1], 90), ]
baubles$color <- as.character(baubles$color)
baubles$color[1:30] <- rep("red", times = 30)
baubles$color[31:60] <- rep("blue", times = 30)
baubles$color[61:90] <- rep("yellow", times = 30)
#baubles$color <- factor(baubles$color, levels = c('red', 'blue', 'yellow'))

colnames(baubles)[3] <- 'col'


ggplot(baubles, aes(x = x, y = y)) + 
  geom_polygon(data = rect, mapping = aes(x=x,y=y), fill = 'brown') + 
  geom_point(data = df, mapping = aes(x = x, y = y), colour = df$color) + 
  ylim(-0.5, 11) +
  geom_image(data = img, mapping = aes(image = image), size = .3) + 
  theme(
    panel.border = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.background = element_blank(),
    axis.title = element_blank(),
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks = element_blank()
  ) +
  geom_point(colour = baubles$col, size = 3) +
  transition_states(baubles$col, transition_length = 1, state_length = 1) +
  enter_fly()