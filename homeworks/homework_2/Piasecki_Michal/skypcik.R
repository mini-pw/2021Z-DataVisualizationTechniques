install.packages('dplyr')
install.packages('ggplot2')
library(dplyr)
library(ggplot2)
options(scipen = 999)
dane <- read.csv('owid-covid-data.csv')
selected_countries = c("United Kingdom", "Germany", "Italy", "Portugal", "Poland", "Austria")
data_for_chart <- dane %>%
  filter(date == "2020-10-11") %>%
  filter(location %in% selected_countries) %>%
  select(location,total_tests)
data_for_chart$location = c("Austria", "Germany", "Italy", "Poland", "Portugal", "UK")
data_for_chart$total_tests = data_for_chart$total_tests / 1000
ggplot(data_for_chart, aes(x = location, y = total_tests, fill = location)) + geom_bar(stat = "identity", show.legend = FALSE) +
  labs(title = "Overall tests in countries", x = "Country", y = "Tests (in thousands)") +
  theme(
    plot.title = element_text(size=13, face="bold.italic"),
    axis.title.x = element_text(size=13, face="bold"),
    axis.title.y = element_text(size=13, face="bold")
  ) 
  
  
  

  

