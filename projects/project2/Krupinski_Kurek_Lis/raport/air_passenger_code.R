library(ggplot2)
library(dplyr)
library(stringi)

air_passengers <- read.csv(file = 'data/air_passengers.tsv', sep = '\t', header = TRUE)
countries <- c("DE", "UK", "NO", "NL")

rows <- rep(c("M,PAS,PAS_CRD,TOTAL,TOT,"), length(countries))

countries <- paste0(rows, countries)

air_passengers %>%
  rename(country = freq.unit.tra_meas.tra_cov.schedule.geo.TIME_PERIOD) %>%
  filter(country %in% countries) -> df

year <- rep(c("2019", "2020"),each=12)[1:21]
month <- rep(1:12, length.out=21)

passengers_DE <- as.numeric(df[df$country == "M,PAS,PAS_CRD,TOTAL,TOT,DE", 2:22])
passengers_UK <- as.numeric(df[df$country == "M,PAS,PAS_CRD,TOTAL,TOT,UK", 2:22])
passengers_NO <- as.numeric(df[df$country == "M,PAS,PAS_CRD,TOTAL,TOT,NO", 2:22])
passengers_NL <- as.numeric(df[df$country == "M,PAS,PAS_CRD,TOTAL,TOT,NL", 2:22])

df_DE <- data.frame(month, year, passengers_DE)
df_UK <- data.frame(month, year, passengers_UK)
df_NO <- data.frame(month, year, passengers_NO)
df_NL <- data.frame(month, year, passengers_NL)


# Germany

ggplot(data = df_DE, aes(
  x = month, y = (passengers_DE/1000000), group = year, color = year
)) +
  geom_line(size=1.5) +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 12)) +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 6)) +
  ylab("passengers [mln]") +
  ggtitle("Air passenger transport in Germany") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

# United Kingdom

ggplot(data = df_UK, aes(
  x = month, y = (passengers_UK/1000000), group = year, color = year
)) +
  geom_line(size=1.5) +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 12)) +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 6)) +
  ylab("passengers [mln]") +
  ggtitle("Air passenger transport in UK") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

# Netherlands

ggplot(data = df_NL, aes(
  x = month, y = (passengers_NL/1000000), group = year, color = year
)) +
  geom_line(size=1.5) +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 12)) +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 6)) +
  ylab("passengers [mln]") +
  ggtitle("Air passenger transport in Netherlands") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

# Norway

ggplot(data = df_NO, aes(
  x = month, y = (passengers_NO/1000000), group = year, color = year
)) +
  geom_line(size=1.5) +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 12)) +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 6)) +
  ylab("passengers [mln]") +
  ggtitle("Air passenger transport in Norway") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

