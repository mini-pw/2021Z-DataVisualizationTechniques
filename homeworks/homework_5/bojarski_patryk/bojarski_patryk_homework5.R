library(ggplot2)
library(colortools)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path)) 

data <- data.frame(percents = c(46, 6.3, 42.6, 5.1, 25.6, 9.4, 59.9, 5.1),
                   status = as.factor(rep(c("pracujący", "bezrobotni", "bierni zawodowo", "nieustalony status"), 2)),
                   year = as.factor(c(rep(">15", 4), rep("15-24", 4))))
data$status <- factor(data$status, levels = c("pracujący", "bezrobotni", "bierni zawodowo", "nieustalony status"))

plotColor <- complementary("#1ecbe1")

betterPlot <- ggplot(data = data, aes(x = status, y = percents, fill = year)) +
  geom_bar(position = "dodge", stat="identity") +
  theme(
    text = element_text(size = 15),
    axis.text.x = element_text(vjust = -1),
    axis.text = element_text(color = "black"),
    axis.ticks.length.x = unit(0, "cm"), 
    panel.border = element_rect(fill = NA),
    panel.background = element_blank(),
    legend.title = element_blank(),
    legend.position = "top",
    axis.title.x = element_text(vjust = -0.5)) +
  xlab("Aktywność ekonomiczna") +
  ylab("Wartość procentowa") +
  scale_y_continuous(expand = c(0, 0), 
                     limits = c(0, 63),
                     breaks = c(0, 10, 20, 30, 40, 50, 60, 70)) +
  scale_fill_manual(values = c(plotColor[2], plotColor[1]), 
                    breaks = c(">15", "15-24"),
                    labels = c("osoby powyżej 15 roku życia (32 679,6 tys)", 
                               "osoby w wieku 15-24 lat (5 223,6 tys)"))

png(file = "better_plot.png", width = 574, height = 381)
print(betterPlot)
dev.off()
