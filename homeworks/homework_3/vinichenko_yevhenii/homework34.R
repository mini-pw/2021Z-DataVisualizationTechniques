library(plotrix)
library(dplyr)
library(ggplot2)


meatData <- as.data.frame(list(
            c("Beacon", "Ribs", "Ham", "Other"), 
            c(42, 13, 13, 32)))
colnames(meatData) <- c("meat_type", "percentage")

# wykres 1

pie3D(meatData$percentage, 
      labels = meatData$meat_type, 
      main = "Pig meat preferences", 
      explode=0.1, 
      radius=.9, 
      labelcex = 1.2,  
      start=0.7)

# wykres 2

meatData$meat_type <- factor(meatData$meat_type, levels = c( "Other", "Ham", "Ribs", "Beacon"))

meatData <- meatData[order(desc(meatData$meat_type)), ]

meatData %>% 
   mutate(color = ifelse(meat_type == "Beacon", "yes", "no")) -> meatData


ggplot(meatData, aes(x=meat_type, y=percentage, fill = color)) + 
   geom_bar(stat='identity') +
   coord_flip() + 
   theme(legend.position = "none", axis.title.y = element_blank()) +
   scale_fill_manual( values = c( "yes"="#800000", "no"="darkgray" ), guide = FALSE )




# dane z ankiety
data <- read.csv("compareGraphs.csv", stringsAsFactors = FALSE)

colnames(data) <- c("time", "pie1", "pie2", "bar1", "bar2", "like")
# write.csv(data, "compareGraphs.csv", row.names=FALSE)

data %>% 
   filter(pie1 == "Yes", pie2 != "Equal") %>%
   summarise(count = n())

data %>% filter(pie1 == "Yes") %>%
   summarise(count = n())



 

