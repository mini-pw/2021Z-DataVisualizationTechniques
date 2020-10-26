library(ggplot2)
library(scales)
library(dplyr)

data <- data.frame("age" = c("0-9", "10-19", "20-29",
                            "30-39", "40-49", "50-59",
                            "60-69", "70-79", "80-89", 
                            "90+"), 
                  "percentage" = c(0, 0.07, 0.03, 0.92,
                                  2.33, 6.06, 18.63, 
                                  28.66, 32.95, 10.34))

data %>% mutate(percentage = percentage/100) -> data
data

my_corrected_plot <- function(data){
  ggplot(data, aes(x = age, y = percentage)) + 
    geom_bar(fill = 'navyblue', stat = 'identity') +
    scale_y_continuous(labels=scales::percent) +
    geom_text(label=percent(data$percentage,.01), vjust = -0.5) +
    ylab("percentage") +
    ggtitle("Distribution of deaths due to the coronavirus (COVID-19) in Poland in 2020, by age group") +
    xlab("age group") + ylab("percentage") +
    theme_classic()
}
my_corrected_plot(data)

         
         