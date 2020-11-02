library(dplyr)
library(ggplot2)
x <- c("pracujący","bezrobotni","bierni zawodowo","nieustalono")
y_mez <- c(55.6,7.3,37.1,0)
y_kob <- c(42,6,52,0)

library(gridExtra)


df <- data.frame(y_mez,y_kob,row.names = x)
colnames(df) = c("Mężczyźni","Kobiety")

df %>% ggplot(aes(x = rownames(df),y = Mężczyźni)) + geom_bar(stat="identity") + theme_light() + labs(x = "Mężczyźni",y = "") -> p1
df %>% ggplot(aes(x = rownames(df),y = Kobiety)) + geom_bar(stat="identity") + theme_light() + labs(x = "Kobiety",y = "")-> p2
grid.arrange(p1,p2,ncol=2)

