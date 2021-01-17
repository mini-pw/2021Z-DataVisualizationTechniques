

x <- c(seq(0,10,0.5), seq(1,9,0.5),seq(2,8,0.5),seq(3,7,0.5),seq(4,6, 0.5),5)
y <- c(rep(0,21),rep(0.05,17), rep(0.1, 13), rep(0.15,9),rep(0.2,5),0.25)
kola <- data.frame(x,y)
colnames(kola) <- c("x", "y")
bomki1 <- data.frame(c(1,8,3,6), c(0.05-0.02, 0.1-0.02, 0.15-0.02, 0.2-0.02))
bomki2 <- data.frame(c(9,2,7,4), c(0.05-0.02, 0.1-0.02, 0.15-0.02, 0.2-0.02))
bomki3 <- data.frame(c(3,7, 5, 5.5, 5) , c(0.05-0.02, 0.05-0.02,0.1-0.02, 0.15-0.02, 0.2-0.02) )
bomki4 <- data.frame(c(5, 3.5, 6.5, 4.5,5) ,c(0.05-0.02,0.1-0.02, 0.1-0.02, 0.15-0.02, 0.25-0.02))
colnames(bomki1) <- c("x", "y")
colnames(bomki2) <- c("x", "y")
colnames(bomki3) <- c("x", "y")
colnames(bomki4) <- c("x", "y")

gwiazda <- data.frame(c(5), c(0.265))
colnames(gwiazda)<- c("x", "y")

snieg <- data.frame(x = runif(150,0,10), y = runif(150,0,0.25), numer = c(rep(1,30),rep(2,30), rep(3,30), rep(4,30), rep(5,30)))

ggplot(snieg, aes(x=x, y=y)) +
  geom_point(data=kola, aes(x=x, y=y), size=25, col="olivedrab3") +
  geom_point(data=bomki1, aes(x=x, y=y), size=20, col="lightpink") +
  geom_point(data=bomki2, aes(x=x, y=y), size=20, col="khaki") +
  geom_point(data=bomki3, aes(x=x, y=y), size=20, col="cadetblue1")+
  geom_point(data=bomki4, aes(x=x, y=y), size=20, col="mediumpurple1")+
  geom_point(data=gwiazda, aes(x=x, y=y),size=20,shape=8, col="khaki",stroke=4, fill="khaki") +
  geom_point(size = 7,shape=8, col="antiquewhite3") +
  transition_states(numer, transition_length = 0,state_length = 0.1, wrap=TRUE) + 
  theme_void()

