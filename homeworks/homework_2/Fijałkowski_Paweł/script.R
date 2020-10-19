install.packages("ggplot2")
install.packages("dplyr")
library(ggplot2)
library(dplyr)
przekroje = c(1,1.2,1.3,1.4,1.6,1.8,2,2.5,3.0)
ceny = c(2100,3000,4100,4100,5300,6700,9595.32,14992.69,21589.45)
df = as.data.frame(matrix(c(przekroje,ceny),ncol=2))
colnames(df) <- c("przekroje","ceny")
ggplot(,aes(x=przekroje,y=ceny,colour=ceny)) + geom_point() -> res
res + labs(x = "Przekrój przepustu",y = "Cena za mb rury")

