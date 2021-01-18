library(ggplot2)
library(gganimate)

n <- 5

x <- 2 - log( seq( n))

x2 <- c()

x2[1] <- 0.25
x2[2] <- 0.25
x2[3] <- 0.5 + x[1]
x2[4] <- 0.5 + x[1] - 2*1/6
x2[5] <- 0.5 + x[1] - 2*2/6
x2[6] <- 0.5 + x[1] - 2*3/6   
x2[7] <- 0.5 + x[1] - 2*4/6
x2[8] <- 0.5 + x[1] - 2*5/6

x2[9] <- 0.5 + x[2]
x2[10] <- 0.5 + x[2] - 1.5*1/6
x2[11] <- 0.5 + x[2] - 1.5*2/6
x2[12] <- 0.5 + x[2] - 1.5*3/6   
x2[13] <- 0.5 + x[2] - 1.5*4/6
x2[14] <- 0.5 + x[2] - 1.5*5/6

x2[15] <- 0.5 + x[3]
x2[16] <- 0.5 + x[3] - 1.2*1/6
x2[17] <- 0.5 + x[3] - 1.2*2/6
x2[18] <- 0.5 + x[3] - 1.2*3/6   
x2[19] <- 0.5 + x[3] - 1.2*4/6
x2[20] <- 0.5 + x[3] - 1.2*5/6

x2[21] <- 0.5 + x[4]
x2[22] <- 0.5 + x[4] - 1*1/6
x2[23] <- 0.5 + x[4] - 1*2/6
x2[24] <- 0.5 + x[4] - 1*3/6   
x2[25] <- 0.5 + x[4] - 1*4/6
x2[26] <- 0.5 + x[4] - 1*5/6

x2[27] <- 0.5 + x[5]
x2[28] <- 0.5 + x[5] - 0.7*1/6
x2[29] <- 0.5 + x[5] - 0.7*2/6
x2[30] <- 0.5 + x[5] - 0.7*3/6   
x2[31] <- 0.5 + x[5] - 0.7*4/6
x2[32] <- 0.5 + x[5] - 0.7*5/6

x2[33] <- 0.20
x2[34] <- 0.20
x2[35] <- 0.20

#plot(x2)


bombki <- c()
wysokosc <- c()
kolor <- c()
wielkosc <-c()

czas <- c()
pelen_czas <- 10

no_of_decs <- 10

for (t in 1:pelen_czas ){
  for (i in 1:35){
    
    if( i <= 2){
      bombki <- append( bombki, runif( 10*no_of_decs,   min = (- x2[i]+0.2), max = (x2[i] - 0.2)))
      kolor <- append( kolor, rep( "brown", 10*no_of_decs))
      wielkosc <- append( wielkosc, rep( 4, 10*no_of_decs))
      wysokosc <- append( wysokosc, rep( i, 10*no_of_decs))
      czas <- append(czas, rep( t, 10*no_of_decs))
    }
    else{
      if( i > 32){
        bombki <- append( bombki, runif( 10*no_of_decs,   min = (- x2[i]+0.2), max = (x2[i] - 0.2)))
        kolor <- append( kolor, rep( "gold", 10*no_of_decs))
        wielkosc <- append( wielkosc, rep( 4, 10*no_of_decs))
        wysokosc <- append( wysokosc, rep( i, 10*no_of_decs))
        czas <- append(czas, rep( t, 10*no_of_decs))
      }
      else{
      
        bombki <- append( bombki, runif( 10*no_of_decs,   min = (- x2[i]+0.2), max = (x2[i] - 0.2)))
    
        if ( i %% 2 == 1){
          kolor <- append( kolor, rep( "green4", 7*no_of_decs))
          kolor <- append( kolor, rep( "gold", no_of_decs))
          kolor <- append( kolor, rep( "red", no_of_decs)) 
          kolor <- append( kolor, rep( "white", no_of_decs))
          wielkosc <- append( wielkosc, rep( 4, 6*no_of_decs))
          wielkosc <- append( wielkosc, rep( 1, no_of_decs))
          wielkosc <- append( wielkosc, rep( 2, no_of_decs))
          wielkosc <- append( wielkosc, rep( 2, no_of_decs)) 
          wielkosc <- append( wielkosc, rep( 2, no_of_decs))
        }
        else{
          kolor <- append( kolor, rep( "green", 10*no_of_decs))
          wielkosc <- append( wielkosc, rep( 4, 10*no_of_decs))
        }
    
        wysokosc <- append( wysokosc, rep( i, 10*no_of_decs))
        czas <- append(czas, rep( t, 10*no_of_decs))
      }
    }
  }
}

dff <- data.frame( bombki = bombki, wys = wysokosc, czas = czas, kolor = kolor, wielk = wielkosc)



p <- ggplot( data = dff, aes( x = wys, y = bombki, colour = kolor)) +
  geom_point(  aes(size = wielkosc), stat = "identity") + 
  coord_flip() + 
  scale_color_manual( values = c("brown", "gold", "green3","green2", "red", "honeydew2")) + 
  theme_void( )+
  theme( legend.position = "none")
p
anim <- p + transition_states(
  czas, 
  transition_length = pelen_czas,
  state_length = 0.5
) 

anim_save("choinka.gif", anim)
anim


