library(ggplot2)
library(dplyr)
library(gganimate)
library(gifski)
library(ggimage)

max_width <- 10
n <- 25
widths1 <- c(seq(max_width, 1, by = -0.5), 0.5, 0.25)
widths2 <- c(widths1[3:length(widths1)], 0.5)
widths <- c(widths1, widths2)
y <- c(seq(from = 1, length.out = length(widths1), by = 2),
       seq(from = 2, length.out = length(widths2), by = 2))
y <- y[-length(y)]
lev <- list()
for(i in 1:length(widths)) {
  lev[[i]] <- runif(n = n * widths[i], min = -widths[i], max = widths[i])
}
df <- data.frame(x = lev[[1]], y = rep(y[1], n * widths[1]))
for(i in 2:length(widths)) {
  tmp <- data.frame(x = lev[[i]], y = rep(y[i], n * widths[i]))
  df <- rbind(df, tmp)
}
df <- df[df$y != 41, ]
df <- df[df$y != 39, ]
df$col <- "darkgreen"
df$size <- 7
na.omit(df)


n <- 25
tmp <- data.frame(x = runif(n = n * 30, min = -0.5, max = 0.5),
                  y = runif(n = n * 30, min = -4, max = 1))
tmp$col <- "#662506"
tmp$size <- 7
df <- rbind(tmp, df)
df <- rbind(df, df, df)
df$time <- rep(1:3, each = nrow(df)/3)
df$image <- "https://thehomedepotbackyard.com/wp-content/uploads/2017/07/empty-png.png"

ind <- sample(x = which(df$col == "darkgreen"), size = 60, replace = FALSE)
tmp <- df[ind, 1:2]
tmp$size <- 10
tmp$col = "darkgreen"
tmp$time <- rep(1:3, each = nrow(tmp) / 3)
tmp$image <- "https://lh3.googleusercontent.com/proxy/hYhobcm7r3PH-vtx0V5aE3fFm-Uu29ce8ZXw2qCbE0KWPzdv2g0Phibl8LHCXcH4S7X5rsqRpPhwjoOmQsiT88NO9djNt2tC"
df <- rbind(df, tmp)





plot <- ggplot(df, aes(x = x, y = y)) + 
  geom_point(color = df$col, size = df$size) +
  geom_image(aes(image = image), size = .1) +
  theme_light() +
  theme(panel.border = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_blank(),
        axis.title = element_text(color = "white"), 
        axis.text = element_text(color = "white"), 
        axis.ticks = element_line(color = "white"))

choinka <- plot +
  transition_states(
    time,
    transition_length = 0,
    state_length = 0.0005
  )

animate(choinka, nframes = 20, fps = 30, width = 1000, height = 1200,
        renderer = gifski_renderer('choinka.gif'))
  