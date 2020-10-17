library(ggplot2)
library(colortools)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path)) 

frontalSinusData <- data.frame(number = c(10, 12, 14, 4, 4, 11),
                               gender = factor(c("male", "female", "male", "female", 
                                                 "male", "female")),
                               pattern = factor(c("Symmetry", "Symmetry", 
                                                  "Left assymetry", "Left assymetry", 
                                                  "Right assymetry", "Right assymetry")))

frontalSinusData$gender <- factor(frontalSinusData$gender, 
                                  levels = c("male", "female"))

frontalSinusData$pattern <- factor(frontalSinusData$pattern, 
                                   levels = c("Symmetry", "Left assymetry", 
                                              "Right assymetry"))

plotColor <- complementary("#DF206D")

betterPlot <- ggplot(data = frontalSinusData, aes(x = pattern, y = number, fill = gender)) + 
  geom_col(position = "dodge") +
  xlab("") +
  ylab("Number of cases") +
  theme(
    text = element_text(size = 24),
    axis.text.x = element_text(vjust = -1),
    axis.text = element_text(color = "black"),
    axis.ticks.length.x = unit(0, "cm"), 
    panel.border = element_rect(fill = NA),
    panel.background = element_blank(),
    legend.title = element_blank(),
    legend.position = "top"
  ) +
  scale_fill_manual(values = c(plotColor[2], plotColor[1]), 
                     breaks = c("male", "female"),
                     labels = c("males", "females")) +
  scale_y_continuous(expand = c(0, 0), 
                     limits = c(0, max(frontalSinusData$number) + 0.5),
                     breaks = seq(0, 16, 2))

png(file = "better_plot.png", width = 574, height = 381)
print(betterPlot)
dev.off()
