library(ggplot2)
library(ggimage)
library(sp)

tree <- data.frame(
  x = c(-50,-30,-40,-20,-30,-10,-20,0,20,10,30,20,40,30,50),
  y = (c(10,15,15,20,20,25,25,30,25,25,20,20,15,15,10)-5)*2
)

stomp <- data.frame(
  x = c(-12.5,-12.5,12.5,12.5),
  y = c(0, 10, 10, 0)
)

baubels <- data.frame(spsample(Polygon(tree), n = 20, "random"), image = sample(c("https://cdn.pixabay.com/photo/2020/12/12/16/28/bauble-5825944_960_720.png",
                                                                      "https://cdn.pixabay.com/photo/2020/11/22/21/20/bauble-5768047__340.png",
                                                                      "https://cdn.pixabay.com/photo/2016/03/31/23/13/bauble-1297473_960_720.png",
                                                                      "https://cdn.pixabay.com/photo/2016/03/31/23/29/bauble-1297660_960_720.png",
                                                                      "https://cdn.pixabay.com/photo/2016/03/31/23/27/bauble-1297635_960_720.png"),
                                                                    size=10, replace = TRUE))

p <- ggplot(tree, aes(x=x, y=y)) +
  geom_polygon(aes(fill="a")) +
  geom_polygon(data=stomp, aes(x=x,y=y, fill="b"))+
  scale_fill_manual("",values=c("darkgreen","brown")) +
  geom_image(data=baubels, aes(image=image), size=0.1) +
  geom_image(data=data.frame(x=c(0),y=c(50),image=c("https://cdn.pixabay.com/photo/2013/07/13/11/42/star-158502_1280.png")), aes(image=image), size=0.15) +
  ylim(0,55) +
  theme(
    axis.title = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.grid = element_blank(),
    legend.position = "none",
    plot.background = element_rect(fill = "transparent", color = NA),
    panel.background = element_rect(fill = "transparent")
  )
p