library(ggplot2)
library(gganimate)
library(ggthemes)
library(gifski)
library(png)
library(grid)

# kształt choinki
df <- data.frame(n = c(0))

for (i in 1:30){
  df1 <- data.frame(n = rep(100 - i, i))
  df <- rbind(df, df1)
}

j = 1
for (i in 30:60){
  df1 <- data.frame(n = rep(100 - i, j))
  df <- rbind(df, df1)
  j = j + 2
}

j = 1
for (i in 60:100){
  df1 <- data.frame(n = rep(100 - i, j))
  df <- rbind(df, df1)
  j = j + 3
}

df1 <- data.frame(n = c(101))
df <- rbind(df, df1)

df$x <- rep(1, length(df$n))


# duża gwiazdka na szczycie
gwiazdka_duza <- data.frame(x = c(1),
                            n = c(100))

# rysuję choinkę
p <- 
  ggplot() +
  geom_violin(data = df, aes(x = x, y = n), fill = "#00ba38") +
  geom_point(data = gwiazdka_duza, aes(x = x, y = n, stroke = 50), color = "yellow", pch = 42) +
  theme_void() +
  theme(plot.background = element_rect(fill = "black"),
        legend.position = "none") 
p
ggsave("tree0.png", p)




# bombki
paleta_barw <- rep(c("#0032ff", "#fdfe07", "#ff0104", "#f56801"), 7)

bombki <- data.frame(x = c(0), n = c(0), bombki_colours = paleta_barw[1], proba = c(0))

for (i in 1:10){
  bombki_tmp <- data.frame(x = c(0.95, 1.05, 0.75, 1.25, 0.95, 1.05, 1.07, 0.95, 0.9, 0.97, 1.02, 0.97, 1, 0.88, 0.85, 0.7, 1.15, 1.16, 1.3, 1.05),
                       n = c(15, 10, 12, 12, 30, 50, 25, 42, 47, 58, 62, 68, 75, 10, 20, 10, 20, 7, 9, 39),
                       bombki_colours = sample(paleta_barw, 20),
                       proba = rep(i, 20))
  bombki <- rbind(bombki, bombki_tmp)
}

bombki <- bombki[-1, ]

# generuję wykres animowany
# wczytuję zieloną choinkę jako tło i potem dodaję animacje; 
# próbowałem zrobić wszystko w jednym kodzie (na dole pliku), ale geom_violin() blokował w jakiś sposób gganimate()

img <- readPNG("tree0.png")

q <- 
  ggplot(bombki, aes(aes(x = x, y = n, stroke = 5))) +
  annotation_custom(rasterGrob(img, 
                               width = unit(1,"npc"),
                               height = unit(1,"npc")), 
                    0.6, 1.4, 0, 90) +
  xlim(0.6, 1.4) +
  ylim(0, 85) +
  geom_point(data = bombki, aes(x = x, y = n, stroke = 5), colour = bombki$bombki_colours) +
  theme_void() +
  theme(plot.background = element_rect(fill = "black"),
        legend.position = "none") +
  transition_states(proba,
                    transition_length = 1,
                    state_length = 0.5)

animate(q, height = 492, width = 673)
anim_save("animation.gif")


# kod, który byłby ładniejszy, ale z jakiegoś powodu geom_violin() nie pozwala na skompilowanie gganimate()

#p <- ggplot(bombki, aes(x = x, y = n)) +
  #geom_violin(data = df, fill = "#00ba38") +
  #geom_point(aes(colour = bombki_colours, stroke = 5), colour = bombki$bombki_colours) +
  #theme_void() +
  #geom_point(data = gwiazdka_duza, aes(x = x, y = n, stroke = 50), color = "yellow", pch = 42) +
  #theme(plot.background = element_rect(fill = "black"),
  #      legend.position = "none") +
  #transition_states(proba,
  #                    transition_length = 2,
  #                   state_length = 1)
  
#anim_save("animation.gif", p)


#p <- 
#  ggplot() +
#    geom_violin(data = df, aes(x = x, y = n), fill = "#00ba38") +
#    geom_point(data = gwiazdka_duza, aes(x = x, y = n, stroke = 50), color = "yellow", pch = 42) +
#    geom_point(data = bombki, aes(x = x, y = n, stroke = 5), colour = bombki$bombki_colours) #+
#    
#    transition_states(as.factor(as.character(proba)),
#                    transition_length = 2,
#                    state_length = 1) +
#    theme_void() +
#    theme(plot.background = element_rect(fill = "black"),
#        legend.position = "none") 
#  
#animate(p)







