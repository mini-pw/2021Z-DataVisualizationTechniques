library(ggplot2)
library(ggiraph)
library(shiny)

triangles_x_coords <- rep(0,24)
triangles_y_coords <- rep(0,24)

balls_x_coords <- c(3,8,13,5,8,11,6,10,8)
balls_y_coords <- c(5.5,5.5,5.5,10.5,10.5,10.5,15.5,15.5,20.5)
balls_onclick <- c(sprintf("window.open(\"%s%s\")",
                           "https://www.filmweb.pl/film/Cicha+noc-2017-790309",""),
                   sprintf("window.open(\"%s%s\")",
                           "https://www.filmweb.pl/film/Listy+do+M.-2011-613510",""),
                   sprintf("window.open(\"%s%s\")",
                           "https://www.filmweb.pl/film/Holiday-2006-261979",""),
                   sprintf("window.open(\"%s%s\")",
                           "https://www.filmweb.pl/film/Kevin+sam+w+domu-1990-6721",""),
                   sprintf("window.open(\"%s%s\")",
                           "https://www.filmweb.pl/film/Renifer+Niko+ratuje+%C5%9Awi%C4%99ta-2008-446075",""),
                   sprintf("window.open(\"%s%s\")",
                           "https://www.filmweb.pl/film/Grinch%3A+%C5%9Awi%C4%85t+nie+b%C4%99dzie-1966-31890",""),
                   sprintf("window.open(\"%s%s\")",
                           "https://www.filmweb.pl/film/To+w%C5%82a%C5%9Bnie+mi%C5%82o%C5%9B%C4%87-2003-99390",""),
                   sprintf("window.open(\"%s%s\")",
                           "https://www.filmweb.pl/film/Kochajmy+si%C4%99+od+%C5%9Bwi%C4%99ta-2015-742627",""),
                   sprintf("window.open(\"%s%s\")",
                           "https://www.filmweb.pl/film/W+krzywym+zwierciadle%3A+Witaj%2C+%C5%9Awi%C4%99ty+Miko%C5%82aju-1989-11500",""))



balls <- data.frame(
  x = balls_x_coords,
  y = balls_y_coords,
  onclick = balls_onclick
)

chain_x1 <- c(seq(2.5,13.5,0.2))
chain_x2 <- c(seq(4,12,0.2))
chain_x3 <- c(seq(6,10,0.2))

chain1 <- data.frame(
  x = chain_x1,
  y = 8+sin(chain_x1)
)

chain2 <- data.frame(
  x = chain_x2,
  y = 13+sin(chain_x2)
)

chain3 <- data.frame(
  x = chain_x3,
  y = 18+sin(chain_x3)
)


triangles_x_coords[1] <- 0
triangles_x_coords[2] <- 16
triangles_x_coords[3] <- 8
triangles_y_coords[1] <- 4
triangles_y_coords[2] <- triangles_y_coords[1]
triangles_y_coords[3] <- triangles_y_coords[1] + 16*sqrt(3)/2

for (i in seq(4,24,3)) {
  triangles_x_coords[i] <- triangles_x_coords[i-3]+1
  triangles_x_coords[i+1] <- triangles_x_coords[i+1-3]-1
  triangles_x_coords[i+2] <- 8
  triangles_y_coords[i] <- triangles_y_coords[i-3]+ 2.5
  triangles_y_coords[i+1] <- triangles_y_coords[i]
  triangles_y_coords[i+2] <- triangles_y_coords[i] + (triangles_x_coords[i+1]-triangles_x_coords[i])*sqrt(3)/2
}

triangles_x_coords
triangles_y_coords

positions <- data.frame(
  id = rep(c('1', '2', '3', '4', '5', '6', '7', '8'), each=3),
  x = triangles_x_coords,
  y = triangles_y_coords
)

christmas <- ggplot() +
  geom_polygon(data=positions,aes(x=x,y=y, group=id),fill="green4")+
  geom_point_interactive(data = balls, aes(x = x, y = y, onclick=onclick, size = 10),color="deeppink2")+
  geom_point(data = chain1, aes(x=x,y=y,size=4),color="white")+
  geom_point(data = chain2, aes(x=x,y=y,size=4),color="white")+
  geom_point(data = chain3, aes(x=x,y=y,size=4),color="white")+ theme(legend.position = "none")+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())


function(input, output, session){
  
  output$christmas <- renderGirafe({
  
  girafe(ggobj = christmas)
  
  }
)
}