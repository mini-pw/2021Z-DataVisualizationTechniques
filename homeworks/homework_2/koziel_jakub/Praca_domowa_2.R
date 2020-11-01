library(ggplot2)

df <-
  data.frame(
    "Age" = c(
      "Under 30",
      "30-39",
      "40-49",
      "50-59",
      "60-69",
      "70-79",
      "80-89",
      "Over 90"
    ),
    "Number_of_deaths" = c(0, 11, 26, 67, 155, 328, 523, 272)
  )
df$Age <- factor(df$Age, levels = df$Age)



ggplot(df, aes(x = Age, y = Number_of_deaths)) +
  geom_bar(stat = "identity", fill = "#00aedb") +
  ggtitle("Deaths due to COVID-19 between August 1 and October 2 in each group of age") +
  ylab("Number of deaths") +
  geom_text(aes(label = Number_of_deaths),
            vjust = -0.5,
            size = 4.5) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 13),
    axis.text = element_text(size = 12),
    axis.title = element_text(size = 16)
  )
