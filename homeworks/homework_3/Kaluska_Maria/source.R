library(ggplot2)
library(ggthemes)

x_axis <- c("a", "b", "c", "d")

plot_1_data <- data.frame(x = x_axis, y = c(10, 20, 25, 45))

bar_plot_1 <- ggplot(plot_1_data, aes(x = x, y = y)) +
  geom_col(fill = "#4F772D") +
  theme(panel.grid.minor = element_blank()) +
  scale_y_continuous(breaks = c(25, 50, 75, 100), limits = c(0,51))
  
pie_plot_1 <- ggplot(plot_1_data, aes(x = '', y = y, fill = x)) +
  geom_bar(width = 1, stat = "identity") + coord_polar("y", start=0) +
  theme(axis.ticks.y = element_blank(), axis.text.y = element_blank(), axis.text.x=element_blank(),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())


plot_2_data <- data.frame(x = c("a", "b", "c", "d", "e"), y = c(5, 9, 17, 28, 41))

bar_plot_2 <- ggplot(plot_2_data, aes(x = x, y = y)) +
  geom_col(fill = "#4F772D") +
  theme(panel.grid.minor = element_blank()) +
  scale_y_continuous(breaks = c(25, 50, 75, 100), limits = c(0,51))

pie_plot_2 <- ggplot(plot_2_data, aes(x = '', y = y, fill = x)) +
  geom_bar(width = 1, stat = "identity") + coord_polar("y", start=0) +
  theme(axis.ticks.y = element_blank(), axis.text.y = element_blank(), axis.text.x=element_blank(),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())


plot_3_data <- data.frame(x = x_axis, y = c(7, 10, 19, 64))

bar_plot_3 <- ggplot(plot_3_data, aes(x = x, y = y)) +
  geom_col(fill = "#4F772D") +
  theme(panel.grid.minor = element_blank()) +
  scale_y_continuous(breaks = c(25, 50, 75, 100), limits = c(0,76))

pie_plot_3 <- ggplot(plot_3_data, aes(x = '', y = y, fill = x)) +
  geom_bar(width = 1, stat = "identity") + coord_polar("y", start=0) +
  theme(axis.ticks.y = element_blank(), axis.text.y = element_blank(), axis.text.x=element_blank(),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())

plot_4_data <- data.frame(x = c("a", "b", "c", "d", "e"), y = c(2, 21, 25, 26, 26))

bar_plot_4 <- ggplot(plot_4_data, aes(x = x, y = y)) +
  geom_col(fill = "#4F772D") +
  theme(panel.grid.minor = element_blank()) +
  scale_y_continuous(breaks = c(25, 50, 75, 100), limits = c(0,51))

pie_plot_4 <- ggplot(plot_4_data, aes(x = '', y = y, fill = x)) +
  geom_bar(width = 1, stat = "identity") + coord_polar("y", start=0) +
  theme(axis.ticks.y = element_blank(), axis.text.y = element_blank(), axis.text.x=element_blank(),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())
