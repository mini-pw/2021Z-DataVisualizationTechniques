library(ggplot2)
library(gganimate)

WIDTHBRANCH = 3;
WIDTHTRUNK = 1.5;
HEIGHTLEVEL = 5.5;
HEIGHTTRUNK = 2;
NUMBEROFLEVELS = 5;
x = c(0,WIDTHTRUNK/2,rep(c(WIDTHTRUNK/2,WIDTHTRUNK/2+WIDTHBRANCH),NUMBEROFLEVELS-1),0);
x2 = rev(x) *(-1);
X = c(x,x2);
producter = rep(seq(1,NUMBEROFLEVELS-1), each=2);
y = c(0,0,producter*HEIGHTTRUNK,1.2*NUMBEROFLEVELS*HEIGHTTRUNK);
y2 = rev(y);
Y = c(y,y2);
df <- data.frame(X,Y)
p <- ggplot(df,aes(x=X,y=Y))

x_bomb = (WIDTHBRANCH + WIDTHTRUNK/2) / 2 + runif(1);
X_bomb = rep(c(x_bomb,-x_bomb+runif(1)),NUMBEROFLEVELS/2);

Y_bomb = seq(HEIGHTTRUNK + HEIGHTLEVEL/2, by=HEIGHTLEVEL/2 , length=NUMBEROFLEVELS-1);

bombki = data.frame(X_bomb,Y_bomb);

q <- ggplot(bombki,aes(x=X_bomb,y=Y_bomb));

anim <- p + geom_path(color="green") + geom_point() + transition_reveal(1:nrow(df)) +
  shadow_wake(wake_length = 0.1, alpha = FALSE)
