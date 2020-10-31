library(ggplot2)
library(dplyr)

data <- read.csv("time_pressure_data.csv", header=TRUE, 
                 colClasses = c("character", "character", "character", "character", 
                                "character", "character", "character", "character", 
                                "character", "character"))
data$Value <- gsub(" ", "", data$Value, fixed = TRUE)
data$Value = as.double(data$Value)
data[is.na(data)] <- 0

data <- data %>%
  rename(czestosc = FRQ_WTPR) %>%
  select(GEO, czestosc, Value) %>%
  filter(czestosc != "Often or always" & czestosc != "Never or sometimes" & 
           czestosc != "No response" & GEO != "European Union - 28 countries (2013-2020)"
         & GEO != "Germany (until 1990 former territory of the FRG)" &
           GEO != "Euro area - 19 countries  (from 2015)" & 
           GEO != "European Union - 27 countries (from 2020)")

data2 <- filter(data, czestosc == "Total")
data <- filter(data, czestosc != "Total")
data <- full_join(data, data2, by = "GEO") %>%
  rename(GEO = 1, czestosc = 2, Value = 3, to_remove = 4, max_value = 5) %>%
  select(-to_remove)
data$Value <- data$Value/data$max_value * 100
data <- select(data, -max_value) %>%
  arrange(GEO)

data_kolejnosc <- filter(data, czestosc == "Always") %>%
  arrange(Value)
data_kolejnosc$numer <- 1:nrow(data_kolejnosc)
data_kolejnosc <- select(data_kolejnosc, GEO, numer)

plot1 <- ggplot(left_join(filter(data, czestosc == "Always"), data_kolejnosc, by = "GEO"), 
                aes(x = reorder(GEO, numer), y = Value, fill = czestosc)) + 
  geom_bar(stat = "identity") +
  labs(title = "Always", x = "European countries", y = "Percentage of people") +
  ylim(0, 60) +
  theme(legend.position="none") +
  scale_fill_manual("czestosc", values = c("Always" = "darkorange")) +
  coord_flip()

plot2 <- ggplot(left_join(filter(data, czestosc == "Often"), data_kolejnosc, by = "GEO"), 
                aes(x = reorder(GEO, numer), y = Value, fill = czestosc)) + 
  geom_bar(stat = "identity") +
  labs(title = "Often", x = "European countries", y = "Percentage of people") +
  ylim(0, 60) +
  theme(legend.position="none") +
  scale_fill_manual("czestosc", values = c("Often" = "orange3")) +
  coord_flip()

plot3 <- ggplot(left_join(filter(data, czestosc == "Sometimes"), 
                          data_kolejnosc, by = "GEO"), 
                aes(x = reorder(GEO, numer), y = Value, fill = czestosc)) + 
  geom_bar(stat = "identity") +
  labs(title = "Sometimes", x = "European countries", y = "Percentage of people") +
  ylim(0, 60) +
  theme(legend.position="none") +
  scale_fill_manual("czestosc", values = c("Sometimes" = "deepskyblue")) +
  coord_flip()

plot4 <- ggplot(left_join(filter(data, czestosc == "Never"), data_kolejnosc, by = "GEO"), 
                aes(x = reorder(GEO, numer), y = Value, fill = czestosc)) + 
  geom_bar(stat = "identity") +
  labs(title = "Never", x = "European countries", y = "Percentage of people") +
  ylim(0, 60) +
  theme(legend.position="none") +
  scale_fill_manual("czestosc", values = c("Never" = "lightskyblue")) +
  coord_flip()

library(cowplot)

finall_plot1 = plot_grid(plot1, plot2)
finall_plot2 = plot_grid(plot3, plot4)