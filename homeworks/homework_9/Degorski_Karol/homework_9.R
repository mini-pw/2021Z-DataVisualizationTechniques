library(ggplot2)
library(ggimage)


korzenx <- runif(2000, -3, 3)
korzeny <- runif(2000, 0, 10)
korzen <- data.frame(korzenx, korzeny)
platkisniegux <- runif(500, -150, 150)
platkisnieguy <- runif(500, 3, 160)

platkisniegu <- data.frame(platkisniegux, platkisnieguy)

choina <- ggplot(platkisniegu, aes(x = platkisniegux, y = platkisnieguy)) + 
  geom_point(color='white', shape = 8)
  
choina <- choina + geom_point(data=korzen, aes(x = korzenx, y = korzeny), size=7, color='brown')

galezie <- function(szer){
  runif(500, -szer, szer)
}


for (i in 10:150) {
  galy <- rep(i, 500)
  gal <- data.frame(galezie(150-i), galy)
  colnames(gal) <- c("x", "y")
  choina <- choina + 
    geom_point(data=gal,aes(x=x,y=y),
               colour='#00e600',size=3)
}



d <- data.frame(x = c(-100, -67, 0, 23, 78, 80, -40, 20, 10, -5, 100),
                y = c(20, 44, 35, 55, 44, 60, 75, 80, 105, 120, 25),
                image = "obr1.png", replace = TRUE)

s <- data.frame(x = 0, y = 150, image = "obr2.png")



choina <- choina  + geom_image(data = d, aes(x=x, y=y, image=image))
choina <- choina  + geom_image(data = s, aes(x=x, y=y, image=image), size = 0.2)

choina <- choina  +
  theme_void() + theme(panel.background = element_rect(fill='#3333cc')) 
choina

